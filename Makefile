ACTIONS  = $(filter %/, $(sort $(wildcard github/*/ go/*/ codefresh/*/)))

labeler:
	for action in $(ACTIONS); do \
		echo "$${action%/}: $${action}**"; \
	done > .github/actions.yml
