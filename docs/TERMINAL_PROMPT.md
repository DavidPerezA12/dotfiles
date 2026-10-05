# Terminal prompt

The Powerlevel10k prompt has broken on me a few times: it jumped when a new
terminal opened, labels floated around, or iTerm showed the plain macOS prompt.
These are the rules that keep it stable. The files involved are `zprofile`,
`zshrc` and `p10k.zsh`.

## Rules

- `zprofile` loads `zshrc` in interactive login shells, so iTerm already has
  Powerlevel10k when it draws the first prompt.
- Instant prompt stays off (`POWERLEVEL9K_INSTANT_PROMPT=off`) in both `zshrc`
  and `p10k.zsh`, and the `~/.cache/p10k-instant-prompt-*` cache is never
  loaded. An old cache draws a stale prompt and then it jumps when `zshrc`
  finishes.
- The right prompt is empty (`POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()`). With
  version segments over there, they overlap the command in narrow windows.
- Every `*_SHOW_SYSTEM` flag is `false`, so `nvm` and the like don't show a
  random `system` label.

Running `p10k configure` overwrites `p10k.zsh`, so after that you have to put
these rules back.

## If it breaks

```bash
typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS POWERLEVEL9K_NVM_SHOW_SYSTEM POWERLEVEL9K_INSTANT_PROMPT
```

It should print:

```text
typeset -a POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( )
typeset POWERLEVEL9K_NVM_SHOW_SYSTEM=false
typeset POWERLEVEL9K_INSTANT_PROMPT=off
```

If iTerm shows the macOS prompt, check `echo "$TERM $TERM_PROGRAM"`. It should
be `xterm-256color iTerm.app`.

Before committing changes to the prompt:

```bash
python3 scripts/verify-zsh-prompt.py
```
