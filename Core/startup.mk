.PHONY: startup
startup:
	@echo  "  ___     _           ___                _    "
	@echo  " | _ \\___| |__ _ _  _/ __|_ __  __ _ _ _| |__ "
	@echo  " |   / -_) / _\` | || \\__ \\ '_ \\/ _\` | '_| / / "
	@echo  " |_|_\\___|_\\__,_|\\_, |___/ .__/\\__,_|_| |_\\_\\ "
	@echo  "                 |__/    |_|                  "

	make --version

.PHONY: print-echo
print-echo:
	@echo Hello $(ECHO_VAR)!
