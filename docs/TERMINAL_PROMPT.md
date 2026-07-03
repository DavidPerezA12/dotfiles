# Terminal Prompt

The terminal prompt is intentionally kept boring and stable. The source of truth
is this repository:

```text
zprofile  -> ~/.zprofile
zshrc     -> ~/.zshrc
p10k.zsh  -> ~/.p10k.zsh
```

## Invariants

- `zprofile` loads `zshrc` for interactive login shells so iTerm gets
  Powerlevel10k before the first prompt render.
- `zshrc` sets `POWERLEVEL9K_INSTANT_PROMPT=off` near the top and never sources
  the `~/.cache/p10k-instant-prompt-*` cache. A stale cache replays an old
  prompt frame, so the layout jumps once zshrc finishes. `p10k.zsh` sets the
  same value so a future `p10k configure` run does not silently re-enable it.
- `p10k.zsh` keeps `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()`. Do not add
  version-manager segments to the right prompt; on narrow windows they collide
  with the command line.
- All `*_SHOW_SYSTEM` prompt flags stay `false`. This prevents segments such as
  `nvm` from showing a floating `system` label.

## If The Prompt Breaks Again

Run this in a real terminal:

```bash
typeset -p POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS POWERLEVEL9K_NVM_SHOW_SYSTEM POWERLEVEL9K_INSTANT_PROMPT
```

Expected:

```text
typeset -a POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( )
typeset POWERLEVEL9K_NVM_SHOW_SYSTEM=false
typeset POWERLEVEL9K_INSTANT_PROMPT=off
```

If iTerm shows the plain macOS prompt, check:

```bash
echo "$TERM $TERM_PROGRAM"
```

Expected in iTerm:

```text
xterm-256color iTerm.app
```

Then run the prompt checks before committing:

```bash
python3 scripts/verify-zsh-prompt.py
```

If `p10k configure` is run again, re-apply the invariants above before committing.
