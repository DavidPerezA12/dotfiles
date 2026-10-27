"""Exercise installer modes in a temporary home with downloads blocked."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

SOURCE = Path(__file__).resolve().parents[1] / 'install.sh'


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='dotfiles test ')
        self.root = Path(self.temporary.name)
        self.repo = self.root / 'checkout with spaces'
        self.home = self.root / 'home'
        self.bin = self.root / 'bin'
        self.home.mkdir()
        self.bin.mkdir()
        (self.repo / 'config/nvim').mkdir(parents=True)
        (self.repo / 'config/ssh').mkdir()
        (self.repo / 'scripts').mkdir()
        shutil.copy2(SOURCE, self.repo / 'install.sh')
        for name in ['zshrc', 'zprofile', 'p10k.zsh', '.gitignore_global']:
            (self.repo / name).write_text('# fixture\n')
        (self.repo / '.gitconfig').write_text('[include]\n path = ~/.gitconfig.local\n')
        (self.repo / 'config/ssh/config').write_text('Host fixture-mini\n HostName fixture.example\n')
        (self.repo / 'scripts/verify-zsh-prompt.py').write_text('raise SystemExit(0)\n')
        self.plugin_marker = self.home / 'init-was-loaded'
        (self.repo / 'config/nvim/init.lua').write_text(
            "vim.fn.writefile({'unexpected'}, vim.env.HOME .. '/init-was-loaded')\n")
        self.forbidden = self.home / 'forbidden-call'
        for tool in ['curl', 'brew', 'defaults']:
            path = self.bin / tool
            path.write_text('#!/bin/sh\nprintf "%s\\n" "$0 $*" >> "$HOME/forbidden-call"\nexit 90\n')
            path.chmod(0o755)
        self.env = dict(os.environ, HOME=str(self.home),
                        PATH=str(self.bin) + ':' + os.environ['PATH'],
                        XDG_CONFIG_HOME=str(self.home / '.config'),
                        XDG_DATA_HOME=str(self.home / '.local/share'),
                        XDG_STATE_HOME=str(self.home / '.local/state'),
                        XDG_CACHE_HOME=str(self.home / '.cache'))
        for key in ['ZDOTDIR', 'ZSH_CUSTOM', 'GIT_CONFIG_GLOBAL', 'GIT_CONFIG_SYSTEM', 'GIT_CONFIG_COUNT']:
            self.env.pop(key, None)
        self.env['GIT_CONFIG_NOSYSTEM'] = '1'

    def tearDown(self):
        self.temporary.cleanup()

    def run_installer(self, *args):
        return subprocess.run(['/bin/bash', str(self.repo / 'install.sh'), *args],
                              env=self.env, text=True, capture_output=True, timeout=20)

    def test_links_only_keeps_backups_and_identity_and_is_repeatable(self):
        (self.home / '.zshrc').write_text('# original\n')
        (self.home / '.gitconfig').write_text('[user]\n name = "Example # Person"\n email = example@example.invalid\n')
        for _ in range(2):
            result = self.run_installer('--links-only')
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertTrue((self.home / '.zshrc').is_symlink())
        backups = list((self.home / '.dotfiles-backups').glob('*/.zshrc'))
        self.assertEqual(len(backups), 1)
        self.assertEqual(backups[0].read_text(), '# original\n')
        self.assertIn('example@example.invalid', (self.home / '.gitconfig.local').read_text())
        name = subprocess.check_output(['git', 'config', '--file', str(self.home / '.gitconfig.local'),
                                        'user.name'], env=self.env, text=True).strip()
        self.assertEqual(name, 'Example # Person')
        config = (self.home / '.ssh/config').read_text()
        self.assertEqual(config.count('Include '), 1)
        result = subprocess.run(['ssh', '-G', '-F', str(self.home / '.ssh/config'), 'fixture-mini'],
                                env=self.env, capture_output=True, text=True, timeout=5)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('hostname fixture.example', result.stdout)
        self.assertFalse(self.forbidden.exists(), self.forbidden.read_text() if self.forbidden.exists() else '')
        self.assertFalse(self.plugin_marker.exists())
        self.assertFalse((self.home / '.nvm').exists())
        self.assertFalse((self.home / '.oh-my-zsh').exists())

    def test_verify_does_not_load_nvim_plugins(self):
        result = self.run_installer('--links-only')
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        result = self.run_installer('--verify', '--no-iterm2')
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertFalse(self.plugin_marker.exists())
        self.assertFalse(self.forbidden.exists())

    def test_conflicting_modes_do_not_mutate_home(self):
        result = self.run_installer('--verify', '--links-only')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.home / '.zshrc').exists())
        self.assertFalse(self.forbidden.exists())

    def test_invalid_private_ssh_config_is_reported_without_connecting(self):
        (self.home / '.ssh').mkdir()
        (self.home / '.ssh/config').write_text('NotARealSshOption yes\n')
        result = self.run_installer('--links-only')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Invalid SSH configuration', result.stdout)
        self.assertFalse(self.forbidden.exists())


if __name__ == '__main__':
    unittest.main()
