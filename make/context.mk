CONTEXT_DIR := context

.PHONY: context-init context-capture

context-init:
	@if find . -type f -name 'CONTEXT.md' \
		-not -path './$(CONTEXT_DIR)/*' \
		-print -quit | grep -q .; then \
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

context-capture:
	@find . -type f -name 'CONTEXT.md' \
		-not -path './$(CONTEXT_DIR)/*' \
		-exec sh -c ' \
			for file do \
				target="$(CONTEXT_DIR)/$${file#./}"; \
				mkdir -p "$$(dirname "$$target")"; \
				cp "$$file" "$$target"; \
			done \
		' sh {} +