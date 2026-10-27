# Neovim Agent Notes

Neovim configuration should be edited here:

```text
<dotfiles-checkout>/config/nvim
```

The live config should point here:

```text
~/.config/nvim -> <dotfiles-checkout>/config/nvim
```

Do not make the repository point to `~/.config/nvim`; that makes the dotfiles
non-portable and hides the real configuration from Git.

Detect the checkout's actual path on the target Mac; do not commit a user's
absolute home directory in these instructions.
