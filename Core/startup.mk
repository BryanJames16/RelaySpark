.PHONY: startup
startup:
	@echo "You are using make for pipeline!"

.PHONY: print-echo
print-echo:
	@echo Hello $(ECHO_VAR)!
