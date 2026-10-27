# macOS setup

What I do on a new Mac, in order, and what the installer doesn't cover. The
Mac mini is set up with
[Serverfiles](https://github.com/DavidPerezA12/ServerFiles), which reuses this
repo for the shared parts; to reach it from here, see
[MAC_MINI.md](MAC_MINI.md).

## Before the installer

```bash
softwareupdate -l
xcode-select --install
```

Review available macOS updates before deciding to install them; an update
can require a restart.

Sign in to the App Store with my Apple ID. The `mas` entries in
`Brewfile.apps` can't install anything without it.

Then clone the repo and run `./install.sh` as described in the
[README](../README.md).

## What the installer covers

- `Brewfile`: terminal, CLI, languages, databases, AI agents, fonts.
- Oh My Zsh, Powerlevel10k, NVM, Claude Code and Bun.

## Apps

Agree on the selection using [INSTALL_CHOICES.md](INSTALL_CHOICES.md) before
installing. The bundle command below is only for a fully selected list;
partial selections install the chosen apps individually.

The list below is for the client Mac. On the Mac mini, follow Serverfiles'
`docs/DEVELOPMENT.md` and ask which development workloads and apps to install
before using the shared definitions. Do not run this whole app bundle there.
Wispr Flow stays on the MacBook client and is excluded from the mini.

The GUI apps are in `Brewfile.apps`, and I install them after the installer:

```bash
brew bundle --file Brewfile.apps
brew bundle check --verbose --file Brewfile.apps   # lists what's missing
```

If an app is already in `/Applications` because I installed it by hand,
`brew` won't overwrite it. To hand it over to Homebrew:

```bash
brew install --cask --adopt <cask>
```

## After the installer

Sign-ins and permissions:

- `gh auth login`, so Git can push to GitHub.
- Add my name, email and any signing key to `~/.gitconfig.local`.
  For public repositories, choose the GitHub-provided noreply address if
  the personal email should stay private. Git identity is stored in commit
  metadata; deleting it from a config later does not scrub old commits.
  The shared config requires an explicit identity instead of guessing an
  address from the computer's hostname:

  ```ini
  [user]
    name = Your Name
    email = you@example.com
  ```

- The essentials first, so the Mac is usable:
  - Chrome: sign in to sync bookmarks and extensions.
  - Tailscale: log in, enable "Start on log in" and "Use Tailscale DNS", and
    install its CLI from the app's settings (it goes to
    `/usr/local/bin/tailscale`).
  - Raycast: set it as the `Cmd+Space` launcher and turn off Spotlight's
    shortcut.
  - The selected Docker, VS Code (Settings Sync) and T3 Code apps: open once
    and log in.
  - On the MacBook client, Wispr Flow: open once, log in and grant microphone
    and Accessibility permissions. It is not part of the Mac mini setup.
  - The agent CLIs: `claude`, `codex`, `opencode`, `copilot`, log in to
    each.
- Bitwarden and Jump Desktop: open once and log in. Grant the permissions
  apps ask for (Accessibility, Screen Recording, Full Disk Access).
- Check that `ssh macmini` and the mini's panel work once Tailscale is logged
  in ([MAC_MINI.md](MAC_MINI.md)).
- Add two bookmarks to Chrome's bookmarks bar, with these names so it's clear
  which is which. The real `<tailnet>` name is in `tailscale status`.

  | Bookmark | What it opens | Address |
  |---|---|---|
  | `CLIProxy` | CLIProxyAPI's panel, on the MacBook | `https://<macbook>.<tailnet>.ts.net/management.html` |
  | `Stats` | The Mac mini's monitoring panel | `https://<mini>.<tailnet>.ts.net:19999/mini/` |

  `CLIProxy` asks for the management key, which is in the Mac's CLIProxyAPI
  config, not here. Both only open with Tailscale on.
  The agent returns the actual clickable addresses from each owning Mac's
  Serve configuration and marks whether they were tested on this client;
  follow Serverfiles' `docs/CONNECTIONS.md`. Do not substitute a pairing link
  for a permanent bookmark or commit private addresses to this repo.
- AlDente and Macs Fan Control need their helper installed on first launch.
- In iTerm2, `iTerm2 > Install Shell Integration`. The `zshrc` loads it if it's
  there, and it's what makes new tabs and splits open in the same directory.
- `nvm install --lts` for Node.

## CLIProxyAPI

`cliproxyapi` (in the `Brewfile`) serves my Claude and Codex subscriptions as
an OpenAI-compatible API, for apps on the MacBook and the iPad. Its config and
logins stay on the Mac, never here:

- `/opt/homebrew/etc/cliproxyapi.conf`: the config, with the API keys and the
  management key.
- `~/.cli-proxy-api/`: the account logins.

It listens only on the Mac, and Tailscale Serve publishes it to the tailnet
with HTTPS, so the iPad reaches it from any network and a café Wi-Fi can't:

```yaml
# /opt/homebrew/etc/cliproxyapi.conf
server:
  host: "127.0.0.1"
  port: 8317
```

```bash
brew services start cliproxyapi
tailscale serve status   # inspect current routes before adding one
tailscale serve --bg http://127.0.0.1:8317
tailscale serve status   # the HTTPS address to use on the iPad
```

The example uses HTTPS port 443 at `/`. Run it only if that route is free
or already belongs to CLIProxy. If another service owns it, select an
available endpoint and use the actual URL printed by Serve. Preserve all
existing mappings; do not reset Serve or enable Funnel for this service.

Never set `host` to `0.0.0.0`: the macOS firewall is off, so that opens it to
every network the Mac joins.

## Installed by hand

Things without a cask or with their own installer:

- [Cisco Packet Tracer](https://www.netacad.com/resources/lab-downloads), needs
  a Netacad account.
- Android SDK packages, with `sdkmanager` once `android-commandlinetools` is in.
- Agent CLIs from their own installers, into `~/.local/bin` or their own
  folder: Grok (`~/.grok`), Kilo (`~/.kilo`), Muse, Jan and `agy`.

## macOS defaults

The system settings I use are in
[`scripts/macos-defaults.sh`](../scripts/macos-defaults.sh): dark mode, tap to
click, Finder in list view with path and status bars opening in `~/Developer`,
the Dock hidden and without recent apps, and screenshots in
`~/Documents/CapturasPantalla`. The installer doesn't run it; I apply it with:

```bash
make macos
```

The Dock only has Apps, Chrome and iTerm; I set that up by hand.
