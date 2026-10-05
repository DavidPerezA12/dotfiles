# Commands and aliases

The commands I actually use in this setup. For anything else, the official
docs are better.

## My aliases

```bash
xcode         # open -a Xcode.app
claude-yolo   # claude --dangerously-skip-permissions
```

## Git

The Git aliases come from the Oh My Zsh `git` plugin. These are the ones I use
most:

```bash
gst           # git status
ga / gaa      # git add / git add --all
gc / gc!      # git commit -v / git commit -v --amend
gco / gcb     # git checkout / git checkout -b
gcm           # git checkout main (or master)
gl / gp       # git pull / git push
gpf           # git push --force-with-lease
gd / gds      # git diff / git diff --staged
glog          # git log --oneline --decorate --graph
grbi          # git rebase -i
gsta / gstp   # git stash / git stash pop
```

The full list is in the
[Oh My Zsh cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet).

Git uses `gh` to log in to GitHub, so on a new machine I run this once and
`git push` just works:

```bash
gh auth login
```

## Node

NVM loads lazily: it only gets sourced the first time you run `nvm`, `node`,
`npm`, `npx` or `corepack`. That keeps new terminals fast.

```bash
nvm install --lts
nvm alias default lts/*
```

## Search

```bash
rg "TODO"                    # search text in the project
fd config                    # find files by name
nvim "$(fd . | fzf)"         # pick a file and open it
rg "TODO" -l | fzf | xargs nvim
```

## Dotfiles

```bash
make verify                  # check links, scripts, prompt, Brewfile and Neovim
make quick                   # relink without Homebrew or plugin sync
make nvim-sync               # update Neovim plugins
exec zsh                     # reload the shell after changing zshrc
p10k configure               # reconfigure the prompt (read TERMINAL_PROMPT.md first)
```
