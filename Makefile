.PHONY: remove start stop state bash logs

cmd=docker-compose
step=----------------

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