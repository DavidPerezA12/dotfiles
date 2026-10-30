# Repository Agent Instructions

This repo describes how David wants each Mac set up: CLI tools, apps, and the
Zsh, Git, SSH, iTerm2 and Neovim config. Your job is usually one of two things:
install from it on a Mac, or update it when David's setup changes.

The Mac mini home server is coordinated by its own repo, Serverfiles
(`~/Developer/ServerFiles`, github.com/DavidPerezA12/ServerFiles). Serverfiles
reuses this repo for the shared tools, apps, shell, Git and Neovim config, so
keep those here and not there. Its services, remote access, monitoring and
power settings live in Serverfiles; this repo only covers how a client reaches
them (`docs/MAC_MINI.md`).

Treat the files as the spec. If a Mac differs from them, either the Mac is
missing something or the spec is out of date; ask David which before changing
either.

## Talking to David

- Follow [docs/INSTALL_CHOICES.md](docs/INSTALL_CHOICES.md) on both client
  and server Macs: identify the host, ask about undecided workloads, offer
  one concrete block and remember accepted choices. Being a client does not
  automatically select the full installer or Brewfiles.
- Write in Spanish unless David switches language. Keep it short and plain;
  file names, commands and app names stay as they are.
- Before installing anything, show the plan: what you'll install, from which
  file, and anything that will be slow, large or need David. Wait for a yes
  unless David already asked for that exact install.
- Ask first for anything heavy (Xcode, Parallels, Docker), paid or licensed,
  anything that uninstalls or replaces something, and anything that changes
  system settings.
- During long installs, send a one-line update when a step finishes or fails,
  not a running log.
- When a step needs David (a password, a sign-in, a macOS permission dialog),
  stop and say exactly what to do: which app, which button, which command to
  run in their own terminal. Then wait for confirmation and check it worked.
- Never ask for passwords, tokens or license keys in the chat. David types them
  in the app, the browser or their own terminal.
- Finish with a short report in three groups: installed and working, failed
  (with the error and what you'd try next), and left for David to do by hand.

## Layout

- `install.sh`: the installer. Idempotent, safe to run again. Installs
  Homebrew and `Brewfile`, Oh My Zsh, Powerlevel10k, NVM, Claude Code and Bun,
  then links the config, moving any file it replaces to
  `~/.dotfiles-backups/<date>/`. It never installs `Brewfile.apps`. It asks
  nothing, so Serverfiles can run it; `--no-brew`, `--no-nvim-sync` and
  `--no-iterm2` skip parts, `--links-only` only links config without downloads
  or app settings, and `--verify` only checks.
- `Brewfile`: terminal and development tools. Installed by `install.sh`.
- `Brewfile.apps`: GUI apps, from Homebrew casks or the App Store (`mas`).
  The "Essentials" section at the top comes first among the selected apps.
  This is not a requirement to install every app on the Mac mini.
- `zshrc`, `zprofile`, `p10k.zsh`, `.gitconfig`, `.gitignore_global`,
  `config/nvim`: symlinked into `HOME`. Edit them here, never in `HOME`.
- `config/ssh/config`: `macmini`, SSH over Tailscale. Included from
  `~/.ssh/config`, which stays local. The real name and account live in
  `~/.ssh/config.local`; `config/ssh/config.local.example` is its template.
- `config/iterm2`: iTerm2 preferences, loaded from this folder.
- `scripts/macos-defaults.sh`: David's macOS settings, applied with
  `make macos`.
- `docs/MACOS_SETUP.md`: sign-ins and things installed by hand.
- `docs/MAC_MINI.md`: how to reach the Mac mini: SSH, T3 Code, its
  monitoring panel, and Tailscale DNS problems.
- `docs/SYNC.md`: compare both checkouts with GitHub and preserve work before
  applying shared changes; symlinks and Tailscale do not sync Macs.

## Setting up a Mac

Work in this order. Check before each step; skip what's already done.

1. Find out where you are: `sw_vers`, `sysctl -n hw.model`, `command -v brew`,
   and whether the repo is already cloned in `~/Developer/dotfiles`. If it's
   the Mac mini (`Macmini`), Serverfiles' `AGENTS.md` leads: it decides which
   parts of this repo to apply, and the rest of this list is a reference.
2. Basics: `xcode-select -p` (if it fails, ask David to run
   `xcode-select --install` and accept the dialog) and `softwareupdate -l`.
   Don't install macOS updates without asking; they restart the Mac.
3. For a client Mac, run `./install.sh` after its effects have been selected.
   For the Mac mini, first follow Serverfiles' `docs/DEVELOPMENT.md`: ask
   which workloads and tools are wanted (Android, iOS/macOS, web/backend,
   databases/containers and coding agents). Do not run the full installer or
   Brewfiles for a partial selection. Preserve choices already made; omitted
   workloads are not missing dependencies to install automatically.
   Homebrew's own installer asks for the admin password the
   first time; if you can't type into it, ask David to run that step in their
   terminal.
4. Run `make verify` and fix what fails before going on.
5. Apps, after David agrees with the plan:
   - Essentials first. Install them one by one with `brew install --cask`, so
     a failure doesn't hide the others. Use `brew bundle --file Brewfile.apps`
     only when every app in that list has been selected; otherwise install
     the agreed apps individually.
   - `mas` entries need David signed in to the App Store. Check with
     `mas list`; if it's empty or fails, ask David to open the App Store and
     sign in.
   - `tailscale-app` and `cloudflare-warp` use `.pkg` installers that ask for
     the admin password. If you can't enter it, give
     David the exact `brew install --cask <name>` command to run.
   - If an app is already in `/Applications` because it was installed by hand,
     `brew` refuses to overwrite it. Use `brew install --cask --adopt <name>`
     instead of deleting anything.
   - AlDente is only for laptops. Leave it out on a Mac mini or iMac.
   - Wispr Flow is for the MacBook client. Exclude it on the Mac mini server;
     do not offer it as a missing shared app or install it to match the MacBook.
   - Check what's missing with
     `brew bundle check --verbose --file Brewfile.apps`.
6. Walk David through "After the installer" in `docs/MACOS_SETUP.md`: GitHub
   (`gh auth login`), Git identity in `~/.gitconfig.local`, Tailscale login,
   app sign-ins and permissions. These stay manual; don't try to automate
   them.
7. Only run `make macos` if David asks.
8. Once Tailscale is logged in, check that Tailscale DNS is on, that
   `ssh macmini` connects and that the mini's panel opens. If something
   doesn't, follow "If something doesn't connect" in `docs/MAC_MINI.md`.
9. If David uses CLIProxyAPI, follow its section in `docs/MACOS_SETUP.md`. It
   must listen on `127.0.0.1` and reach the iPad through Tailscale Serve.
10. Make sure Chrome has the two bookmarks from "After the installer" in
    `docs/MACOS_SETUP.md`: `CLIProxy` (CLIProxyAPI's panel) and `Stats` (the
    mini's monitoring panel). Fill in the real addresses from
    `tailscale status`, open both to check they load, and if they're missing,
    give David each name with its address to add.
    Follow Serverfiles' `docs/CONNECTIONS.md` when returning links: real,
    clickable URLs from the owning host, its actual port/path, required VPN,
    and whether access was tested from this client. Never hand placeholders
    to the user as if they were working addresses. Keep private addresses
    out of the public repository and pairing credentials out of logs.

If something fails, read the error, retry once if it looks transient (network,
lock file), and otherwise report it and move on to the next step instead of
stopping everything.

## Keeping the spec current

- Compare a Mac with the spec using `brew leaves`, `brew list --cask`,
  `mas list` and `/Applications`.
- Add an app only after David confirms it belongs in the spec. Put it in the
  right section of `Brewfile.apps`. Prefer a Homebrew
  cask; use `mas` only for App Store-only apps or ones bought there. Check the
  name with `brew info --cask <name>` or `mas search <name>` before adding it.
- Apps without a cask go in "Installed by hand" in `docs/MACOS_SETUP.md`.
- When a macOS setting changes, read it with `defaults read` and update
  `scripts/macos-defaults.sh` to match.
- Anything installed, running or configured only on the Mac mini belongs in
  Serverfiles, not here. Shared tools and apps stay here, because Serverfiles
  reads them from this repo. Only change `docs/MAC_MINI.md` for the client
  side, for example a new address or port to open from the MacBook or iPad.
- This repo is public: no Tailscale IPs or tailnet names (`*.ts.net`). Write
  `<mini>.<tailnet>.ts.net` and say where to read the real one.
- Never commit secrets, tokens, license keys, private keys or the Git identity;
  those live in `~/.gitconfig.local`, `~/.ssh` or the app itself.
- Before publishing, inspect untracked files and decode binary preference
  fields as well as reviewing text. Exclude saved prompts, workgroups,
  account/session exports, private absolute home paths, logs and image
  metadata containing personal information. Keep audit artifacts and original
  unsanitized exports in a private location outside the repository.
  Also inspect commit authors, committers and trailers: private emails and
  machine hostnames can remain in history after files are cleaned. Prefer
  an explicitly selected GitHub noreply identity for public work. Do not
  rewrite or force-push existing history without explicit authorization.

## Checks

Before finishing a change to the repo, run what applies:

```bash
make lint                                    # shellcheck and zsh syntax
make test                                    # isolated installer regressions
make verify                                  # links, prompt, Brewfile, Neovim
brew bundle list --all --file Brewfile.apps  # the Brewfile parses
```

## Commit Discipline

- When the user asks for commits, inspect the complete diff first and split the
  work into cohesive commits by intent (for example shell configuration, Git
  configuration, editor configuration, docs, or tooling).
- Do not mix unrelated changes in one commit. Keep documentation with the
  configuration it describes, and use explicit paths or partial staging when
  the working tree contains multiple concerns.
- Review the staged diff before every commit. Prefer a small number of
  meaningful, independently reviewable commits over one catch-all commit or
  artificial microcommits.
- Do not include pre-existing user changes unless they belong to the same intent
  and the user asked for them to be committed.
