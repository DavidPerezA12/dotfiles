#!/usr/bin/env python3
"""Verify zsh prompt selection in terminal and non-terminal startup modes."""

from __future__ import annotations

import os
import pty
import select
import subprocess
import sys
import tempfile
import time


CHECK = (
    "print -r -- "
    "tty0=$([[ -t 0 ]] && echo yes || echo no) "
    "tty1=$([[ -t 1 ]] && echo yes || echo no) "
    "tty2=$([[ -t 2 ]] && echo yes || echo no) "
    "theme=${ZSH_THEME-} "
    "p10k=$+functions[p10k]"
)


def run_with_stdout_pty(login: bool, env: dict[str, str] | None = None) -> str:
    master_fd, slave_fd = pty.openpty()
    try:
        with open(os.devnull, "rb") as devnull:
            args = ["zsh", "-lic" if login else "-ic", CHECK]
            proc = subprocess.Popen(
                args,
                stdin=devnull,
                stdout=slave_fd,
                stderr=subprocess.STDOUT,
                env=env,
                text=False,
            )
        os.close(slave_fd)
        chunks: list[bytes] = []
        deadline = time.monotonic() + 5
        while True:
            if proc.poll() is not None:
                while True:
                    ready, _, _ = select.select([master_fd], [], [], 0)
                    if not ready:
                        break
                    try:
                        chunk = os.read(master_fd, 4096)
                    except OSError:
                        chunk = b""
                    if not chunk:
                        break
                    chunks.append(chunk)
                break

            if time.monotonic() > deadline:
                proc.kill()
                raise AssertionError("timed out waiting for zsh prompt check")

            ready, _, _ = select.select([master_fd], [], [], 0.1)
            if not ready:
                continue
            try:
                chunk = os.read(master_fd, 4096)
            except OSError:
                break
            if chunk:
                chunks.append(chunk)
        rc = proc.wait()
        output = b"".join(chunks).decode(errors="replace")
        if rc != 0:
            raise AssertionError(f"zsh exited {rc}: {output}")
        return output
    finally:
        try:
            os.close(master_fd)
        except OSError:
            pass


def run_without_tty() -> str:
    env = os.environ.copy()
    env.pop("TERM_PROGRAM", None)
    env.pop("ITERM_SESSION_ID", None)
    env.pop("DOTFILES_FORCE_TERMINAL", None)
    proc = subprocess.run(
        ["zsh", "-ic", CHECK],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        env=env,
        check=True,
    )
    return proc.stdout


def assert_contains(output: str, *needles: str) -> None:
    missing = [needle for needle in needles if needle not in output]
    if missing:
        raise AssertionError(f"missing {missing!r} in output: {output!r}")


def main() -> int:
    for login in (False, True):
        output = run_with_stdout_pty(login)
        assert_contains(
            output,
            "tty0=no",
            "theme=powerlevel10k/powerlevel10k",
            "p10k=1",
        )
        if all(token in output for token in ("tty0=no", "tty1=no", "tty2=no")):
            raise AssertionError(f"expected a terminal descriptor in output: {output!r}")

    with tempfile.TemporaryDirectory() as zdotdir:
        zprofile = os.path.join(zdotdir, ".zprofile")
        with open(zprofile, "w", encoding="utf-8") as file:
            file.write('source "$HOME/.zprofile"\n')
        env = os.environ.copy()
        env["ZDOTDIR"] = zdotdir
        env["DOTFILES_FORCE_TERMINAL"] = "1"
        env["DOTFILES_ZSHRC_LOADED"] = "1"
        env["_DOTFILES_ZSHRC_LOADED_PID"] = "1"
        output = run_with_stdout_pty(login=True, env=env)
        assert_contains(
            output,
            "tty0=no",
            "theme=powerlevel10k/powerlevel10k",
            "p10k=1",
        )

    output = run_without_tty()
    assert_contains(output, "tty0=no", "tty1=no", "tty2=no", "theme=", "p10k=0")
    if "gitstatus failed to initialize" in output:
        raise AssertionError(f"gitstatus should not start without a terminal: {output!r}")

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as error:
        print(error, file=sys.stderr)
        raise SystemExit(1)
