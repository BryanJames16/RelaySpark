##
# @file test.mk
# @brief Pipeline jobs for testing.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains jobs for performing testing of all kinds except security.
# Security testing such as SAST will be covered on another file.
##

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
