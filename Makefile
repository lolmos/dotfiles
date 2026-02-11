PACKAGES = zsh starship nvim tmux lazygit git bat yazi fzf

.PHONY: install uninstall restow post-install clean help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Stow all packages into ~
	@for pkg in $(PACKAGES); do \
		echo "Stowing $$pkg..."; \
		stow -v -t ~ $$pkg; \
	done

uninstall: ## Unstow all packages from ~
	@for pkg in $(PACKAGES); do \
		echo "Unstowing $$pkg..."; \
		stow -D -v -t ~ $$pkg; \
	done

restow: ## Re-stow all packages (fix stale symlinks)
	@for pkg in $(PACKAGES); do \
		echo "Restowing $$pkg..."; \
		stow -R -v -t ~ $$pkg; \
	done

post-install: ## Install TPM and oh-my-zsh custom plugins if missing
	@if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $$HOME/.tmux/plugins/tpm; \
	else \
		echo "TPM already installed"; \
	fi
	@if [ ! -d "$$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then \
		echo "Installing zsh-autosuggestions..."; \
		git clone https://github.com/zsh-users/zsh-autosuggestions \
			$$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	else \
		echo "zsh-autosuggestions already installed"; \
	fi
	@if [ ! -d "$$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then \
		echo "Installing zsh-syntax-highlighting..."; \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting \
			$$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; \
	else \
		echo "zsh-syntax-highlighting already installed"; \
	fi

clean: ## Remove all stow symlinks and plugin dirs
	@$(MAKE) uninstall
	rm -rf $$HOME/.tmux/plugins/tpm
