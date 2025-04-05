.PHONY: dotnet-test
dotnet-test:
	@echo "Performing unit testing..."
	dotnet test $(DOTNET_SP_TEST_PATH) -v $(DOTNET_SP_TEST_VERBOSITY) $(DOTNET_SP_TEST_ADDITIONAL_FLAGS)
	@echo "Unit test completed!"
