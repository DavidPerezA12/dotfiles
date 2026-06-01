SHELL := /usr/bin/env bash
export HOMEBREW_NO_ENV_HINTS := 1
export HOMEBREW_NO_REQUIRE_TAP_TRUST := 1

.PHONY: help install quick verify brew-check lint nvim-health nvim-sync

help:
	@printf '%s\n' 'Targets:'
	@printf '  %-12s %s\n' 'install' 'Run the full installer'
	@printf '  %-12s %s\n' 'quick' 'Run installer without Homebrew or Neovim plugin sync'
	@printf '  %-12s %s\n' 'verify' 'Run local checks for symlinks, shell scripts, Brewfile, and Neovim'
	@printf '  %-12s %s\n' 'brew-check' 'Check Brewfile dependencies'
	@printf '  %-12s %s\n' 'lint' 'Run shellcheck and shell syntax checks'
	@printf '  %-12s %s\n' 'nvim-health' 'Run Neovim health check'
	@printf '  %-12s %s\n' 'nvim-sync' 'Sync Neovim plugins'

install:
	./install.sh

quick:
	./install.sh --no-brew --no-nvim-sync

verify: lint brew-check nvim-health
	./install.sh --verify

brew-check:
	brew bundle check --file ./Brewfile

lint:
	shellcheck install.sh
	bash -n install.sh
	zsh -n zshrc
	zsh -n zprofile
	zsh -n p10k.zsh

nvim-health:
	nvim --headless "+checkhealth" +qa

nvim-sync:
	nvim --headless "+Lazy! sync" +qa
