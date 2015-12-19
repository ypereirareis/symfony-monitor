.PHONY: remove start stop state bash logs tests


step=----------------
composeFile=tests/docker-compose-$(START_ENV).yml

ifndef START_ENV
    composeFile=docker-compose.yml
endif

cmd=docker-compose -f $(composeFile)

remove: stop
	@echo "$(step) Removing Monitor $(step)"
	@$(cmd) rm -f

start:
	@echo "$(step) Starting Monitor $(step)"
	@$(cmd) up -d elk forwarder

stop:
	@echo "$(step) Stopping Monitor $(step)"
	@$(cmd) stop

state:
	@$(cmd) ps

logs:
	@$(cmd) logs
