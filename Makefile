ACTIONS  = $(filter %/, $(sort $(wildcard github/*/ go/*/)))

labeler:
	for action in $(ACTIONS); do \
		echo "$${action%/}: $${action}**"; \
	done > .github/actions.yml


