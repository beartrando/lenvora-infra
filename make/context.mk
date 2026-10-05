CONTEXT_DIR := context
EXCLUDED_DIRS := services/postgres services/pgbouncer

.PHONY: context-init context-capture

context-init:
	@if find . \
		$(foreach dir,$(EXCLUDED_DIRS),-path './$(dir)' -prune -o) \
		-path './$(CONTEXT_DIR)' -prune -o \
		-type f -name 'CONTEXT.md' -print -quit | grep -q .; then \
		echo "ERROR: CONTEXT.md already exists in the project."; \
		echo "context-init is allowed only for initial setup."; \
		exit 1; \
	fi
	@find $(CONTEXT_DIR) -type f -name 'CONTEXT.md' \
		-exec sh -c ' \
			for file do \
				target="$${file#$(CONTEXT_DIR)/}"; \
				mkdir -p "$$(dirname "$$target")"; \
				cp "$$file" "$$target"; \
			done \
		' sh {} +

context-apply:
	@printf "WARNING: This will overwrite CONTEXT.md files in the project. Continue? [y/N] "; \
	read answer; \
	case "$$answer" in \
		y|Y|yes|YES) ;; \
		*) echo "Aborted."; exit 1 ;; \
	esac
	@find $(CONTEXT_DIR) -type f -name 'CONTEXT.md' \
		-exec sh -c ' \
			for file do \
				target="$${file#$(CONTEXT_DIR)/}"; \
				mkdir -p "$$(dirname "$$target")"; \
				cp "$$file" "$$target"; \
			done \
		' sh {} +

context-capture:
	@find . \
		$(foreach dir,$(EXCLUDED_DIRS),-path './$(dir)' -prune -o) \
		-path './$(CONTEXT_DIR)' -prune -o \
		-type f -name 'CONTEXT.md' \
		-exec sh -c ' \
			for file do \
				target="$(CONTEXT_DIR)/$${file#./}"; \
				mkdir -p "$$(dirname "$$target")"; \
				cp "$$file" "$$target"; \
			done \
		' sh {} +