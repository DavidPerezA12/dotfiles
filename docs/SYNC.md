# Keeping the Macs aligned

Symlinks connect this checkout to HOME on the same Mac. They do not copy
files, installed tools, credentials or project work to another Mac. Tailscale
provides connectivity; it does not synchronize the repositories either.

## Separate the shared spec from the host's role

The shared shell, Git/editor config and package definitions live in dotfiles.
Serverfiles owns server setup and the selection of development workloads on
the mini. Apply the choices already made by the user: Wispr Flow stays on
the MacBook; Android, iOS, databases and containers are selected by workload.
An intentional omission on the mini is not a synchronization failure.

## Inspect both checkouts

Run these separately on each Mac, in each repository being reviewed:

```sh
git status --short --branch
git rev-parse HEAD
git ls-remote origin refs/heads/main
git diff --stat
```

Record untracked files as well as tracked changes. `origin/main` is a cached
local ref until fetched, so a clean status or ahead/behind count does not
prove that the checkout matches GitHub now. Matching HEADs also do not prove
matching working files when one checkout has uncommitted changes.

Review local changes and commits on both machines before updating either.
Reconcile in a separate copy when a checkout is dirty or diverged; retain
backups and machine-local settings. Do not run a blanket pull, reset, clean
or `rsync --delete` across Developer. A project's uncommitted work can belong
to another active task and must be preserved.

## Apply and verify an agreed change

After the reviewed shared change has been explicitly selected for publication,
validate it, publish it, compare its SHA with GitHub, and then update the other
checkout with a fast-forward only when that checkout is clean and can accept
it. Divergence requires reconciliation rather than a forced update.

`make quick` only links configuration, with backups. It does not install tools,
download plugins or write iTerm2 preferences. The full installer has those
additional effects and must not be used for an unselected server workload.

Run `make verify` on a host whose complete Brewfile was selected. For a partial
server setup, verify the selected tools and links separately; a missing
unselected package is expected. In Serverfiles use `scripts/verify.sh` for
the server profile or `scripts/verify.sh --role client` for client checks.
Neither command proves access from another device: follow Serverfiles'
`docs/CONNECTIONS.md` to test each route.

Report these states separately: locally edited, committed, published, applied
on the other Mac, and tested from the client. Do not say everything is synced
until the shared files and the agreed host-specific selections are verified.
