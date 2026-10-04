git-commit-and-push-all:
	@echo "🚀 Commit all repos..."
	@make git-commit-all bip=no
	@echo "🚀 Push all repos..."
	@make git-push-all bip=no
	@make bip

git-commit-all:
	@for dir in $(GIT_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		SERVICE_PATH="$(SERVICE_DIR)/$$dir"; \
		if [ ! -e "$$SERVICE_PATH/.git" ]; then \
			echo "\033[0;31m[!] Skipping $$dir — not a git repo\033[0m"; \
			continue; \
		fi; \
		cd "$$SERVICE_PATH"; \
		if [ -z "$$(git status --porcelain)" ]; then \
			echo "\033[1;33m[-] No changes in $$dir\033[0m"; \
		else \
			git add . && \
			git commit -am "$(COMMIT_MSG)" && \
			echo "\033[0;32m[✓] Committed changes in $$dir\033[0m"; \
		fi; \
		cd - > /dev/null; \
	done \

	@echo "\033[1;33m[*] Checking proto...\033[0m"; \
	cd proto; \
	if [ -z "$$(git status --porcelain)" ]; then \
		echo "\033[1;33m[-] No changes in proto\033[0m"; \
	else \
		git add . && \
		git commit -am "$(COMMIT_MSG)" && \
		echo "\033[0;32m[✓] Commited changes in proto\033[0m"; \
	fi;
	@if [ "$(bip)" != "no" ]; then \
		$(MAKE) bip; \
	fi

	@echo "\033[1;33m[*] Checking monorepo...\033[0m"; \
	if [ -z "$$(git status --porcelain)" ]; then \
		echo "\033[1;33m[-] No changes in monorepo\033[0m"; \
	else \
		git add . && \
		git commit -am "$(COMMIT_MSG)" && \
		echo "\033[0;32m[✓] Commited changes in monorepo\033[0m"; \
	fi;
	@if [ "$(bip)" != "no" ]; then \
		$(MAKE) bip; \
	fi


git-push-all:
	@echo "\033[1;34m[*] Pushing monorepo...\033[0m"
	if git push; then \
		echo "\033[0;32m[✓] Pushed monorepo\033[0m"; \
	else \
		echo "\033[0;31m[✗] Failed to push monorepo\033[0m"; \
	fi

	@for dir in $(GIT_SERVICES); do \
		echo "\033[1;34m[*] Pushing $$dir...\033[0m"; \
		SERVICE_PATH="$(SERVICE_DIR)/$$dir"; \
		cd "$$SERVICE_PATH"; \
		if git push; then \
			echo "\033[0;32m[✓] Pushed $$dir\033[0m"; \
		else \
			echo "\033[0;31m[✗] Failed to push $$dir\033[0m"; \
		fi; \
		cd - > /dev/null; \
	done

	@echo "\033[1;34m[*] Pushing proto...\033[0m"
	cd proto; \
	if git push; then \
		echo "\033[0;32m[✓] Pushed proto\033[0m"; \
	else \
		echo "\033[0;31m[✗] Failed to push proto\033[0m"; \
	fi
	@if [ "$(bip)" != "no" ]; then \
		$(MAKE) bip; \
	fi

	@if [ "$(bip)" != "no" ]; then \
		$(MAKE) bip; \
	fi
