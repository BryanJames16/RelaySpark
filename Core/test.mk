##
# @file test.mk
# @brief Pipeline jobs for testing.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains jobs for performing testing of all kinds except security.
# Security testing such as SAST will be covered on another file.
##

##
# @function     dotnet-test
# @brief        Job for cleaning .NET project or solution (.NET Core)
# @param[in]    DOTNET_TEST_TOOL                     Tools for .NET unit testing: `xunit`, `nunit`, and `mstest`.
# @param[in]    DOTNET_TEST_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_TEST_VERBOSITY                Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    DOTNET_TEST_ADDITIONAL_FLAGS         Additional parameters to pass to `dotnet clean`.
##
.PHONY: dotnet-test
dotnet-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-test

.PHONY: _dotnet-test
_dotnet-test:
	@if [ "$(DOTNET_TEST_TOOL)" = "xunit" ]; then \
		echo "🔧 Installing xUnit 3 templates..."; \
		dotnet new install xunit.v3.templates; \
		echo "✅ Done installing xUnit 3 templates!"; \
	fi
	@echo "🧪 Performing unit testing..."
	dotnet test $(DOTNET_TEST_SP_PATH) -v $(DOTNET_TEST_VERBOSITY) $(DOTNET_TEST_ADDITIONAL_FLAGS)
	@echo "✅ Unit test completed!"

##
# @function     maven-validate
# @brief        Job for validating Maven configurations
# @param[in]    MAVEN_VALIDATE_PROJECT_PATH             Path where the project is located.
# @param[in]    MAVEN_VALIDATE_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_VALIDATE_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: maven-validate
maven-validate:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-validate

.PHONY: _maven-validate
_maven-validate:
	@echo "🧪 Performing maven validate..."
	mvn $(MAVEN_VALIDATE_VERBOSITY) validate $(MAVEN_VALIDATE_PROJECT_PATH) $(MAVEN_VALIDATE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed maven validate!"

##
# @function     maven-test
# @brief        Job for testing Maven applications
# @param[in]    MAVEN_TEST_PROJECT_PATH             Path where the project is located.
# @param[in]    MAVEN_TEST_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_TEST_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: maven-test
maven-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-test

.PHONY: _maven-test
_maven-test:
	@echo "🧪 Performing maven test..."
	mvn $(MAVEN_TEST_VERBOSITY) test $(MAVEN_TEST_PROJECT_PATH) $(MAVEN_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed maven test!"
