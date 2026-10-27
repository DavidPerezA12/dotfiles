SHELL := /usr/bin/env bash
export HOMEBREW_NO_ENV_HINTS := 1

.PHONY: help install quick verify lint test brew-check apps-check macos nvim-sync nvim-health

help:
	@printf '%s\n' 'Targets:'
	@printf '  %-12s %s\n' 'install' 'Run the full installer'
	@printf '  %-12s %s\n' 'quick' 'Relink config only; no downloads or app settings'
	@printf '  %-12s %s\n' 'verify' 'Lint, Brewfile, and the installer checks (links, SSH, iTerm2, prompt, Neovim)'
	@printf '  %-12s %s\n' 'lint' 'shellcheck and shell syntax'
	@printf '  %-12s %s\n' 'test' 'Test installer modes in a temporary home, without downloads'
	@printf '  %-12s %s\n' 'brew-check' 'Check that everything in Brewfile is installed'
	@printf '  %-12s %s\n' 'apps-check' 'List the apps in Brewfile.apps that are missing (never fails)'
	@printf '  %-12s %s\n' 'macos' 'Apply my macOS settings'
	@printf '  %-12s %s\n' 'nvim-sync' 'Update Neovim plugins'
	@printf '  %-12s %s\n' 'nvim-health' 'Open Neovim health check to read it'

install:
	./install.sh

quick:
	./install.sh --links-only

# install.sh --verify already checks the symlinks, the SSH include, iTerm2,
# zsh syntax, the prompt and the Neovim config path.
verify: lint brew-check
	./install.sh --verify

lint:
	shellcheck install.sh scripts/macos-defaults.sh
	bash -n install.sh
	zsh -n zshrc
	zsh -n zprofile
	zsh -n p10k.zsh

test:
	python3 tests/test_installer.py

brew-check:
	brew bundle check --no-upgrade --file ./Brewfile

# Apps are optional and AlDente is laptop-only, so this only reports.
apps-check:
	-brew bundle check --no-upgrade --verbose --file ./Brewfile.apps

macos:
	./scripts/macos-defaults.sh

nvim-sync:
	nvim --headless "+Lazy! sync" +qa

# Interactive on purpose: checkhealth always exits 0, so it's for reading, not
# for verify.
nvim-health:
	nvim +checkhealth
