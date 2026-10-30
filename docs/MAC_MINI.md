# Connecting to the Mac mini

The Mac mini is my home server. It's set up with
[Serverfiles](https://github.com/DavidPerezA12/ServerFiles), which has
everything about what's installed and running on it. This page is only about
reaching it from the MacBook or the iPad.

## What the client needs

- Tailscale, logged in to the same tailnet as the Mac mini, with **Use
  Tailscale DNS** on. Without it the mini's name doesn't resolve. On a Mac,
  check it and turn it on with:

  ```bash
  tailscale debug prefs | grep CorpDNS   # should say true
  tailscale set --accept-dns=true
  ```

  First check `tailscale status --json`: `BackendState` must be `Running`.
  If it is `Stopped`, report that rather than changing DNS or reconnecting
  during a code review. Saved names and IPs do not prove a live connection.

- For SSH, the hosts in [`config/ssh/config`](../config/ssh/config), which
  `install.sh` includes from `~/.ssh/config`, the mini's real name and account
  in `~/.ssh/config.local` (start from
  [`config.local.example`](../config/ssh/config.local.example)), and my key in
  `~/.ssh/id_ed25519` authorized on the Mac mini.
- T3 Code and Jump Desktop, both in `Brewfile.apps`, signed in to the same
  accounts as on the mini.

The iPad uses the same services from its own apps; the steps are in
[Serverfiles' iPad guide](https://github.com/DavidPerezA12/ServerFiles/blob/main/docs/IPAD.md).

## Terminal

```bash
ssh macmini
```

`~/.ssh/config.local` holds the mini's MagicDNS name. Check the actual peer's
DNSName if it changes. If a host key changes after reinstalling the mini, verify
its new fingerprint on the host before removing the old entry.

## T3 Code

T3 Code on the mini has T3 Connect on, so the T3 Code on the MacBook (or
app.t3.codes on the iPad) shows the mini as another environment once both are
signed in to the same T3 account. It doesn't need Tailscale. Threads started
there run on the mini.

## Monitoring

The mini runs Netdata and a one-page panel with CPU, memory, temperatures and
the fan. Both are published with Tailscale Serve, only inside the tailnet:

| What | Address |
|---|---|
| Panel (the `Stats` bookmark) | `https://<mini>.<tailnet>.ts.net:19999/mini/` |
| Netdata | `https://<mini>.<tailnet>.ts.net:19999/` |

The full name is in the Tailscale app, or in `tailscale serve status` on the
mini. It's not written here because this repo is public. How it's installed is
in Serverfiles' `docs/MONITORING.md`.

When handing over links, follow Serverfiles' `docs/CONNECTIONS.md`: give the
real clickable address, the Mac that owns it, the required client/VPN and
whether it was tested from that client. These public placeholders are not
working links. A configured route or a host-local HTTP 200 alone is not a
successful client test.

## Shared files

See [SYNC.md](SYNC.md) before comparing or updating the two Macs. Symlinks
only connect HOME to the local checkout; Tailscale does not sync their files.

## If something doesn't connect

- Check `BackendState` on the client and confirm the mini is online. With
  Tailscale stopped, private DNS and endpoints will not work.
- If both devices are connected but the name does not resolve, inspect Use
  Tailscale DNS, the actual peer DNSName and conflicting VPN/DNS settings.
  Diagnose an iPad-specific failure on the iPad before changing its settings.
- `tailscale ping <mini>` says if the connection is direct or through
  a relay (`via DERP`). A relay works, just slower.
