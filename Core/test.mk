.PHONY: dotnet-test
dotnet-test:
	make _dotnet-test

.PHONY: _dotnet-test
_dotnet-test:
	@if [ "$(DOTNET_SP_TEST_TOOL)" = "xunit" ]; then \
		echo "Installing xUnit 3 templates..."; \
		dotnet new install xunit.v3.templates; \
		echo "Done installing xUnit 3 templates!"; \
	fi
	@echo "Performing unit testing..."
	dotnet test $(DOTNET_SP_TEST_PATH) -v $(DOTNET_SP_TEST_VERBOSITY) $(DOTNET_SP_TEST_ADDITIONAL_FLAGS)
	@echo "Unit test completed!"
