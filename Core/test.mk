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
# @function     axe-scan
# @brief        Job for scanning accessibility violations via axe-scan
# @param[in]    AXE_SCAN_RESULTS_CSV                 CSV file for Axe Scan results.
# @param[in]    AXE_SCAN_ADDITIONAL_PARAMTERS        Additional parameters to pass to axe-scan run command.
# @param[in]    AXE_SCAN_SUMMARY_ENABLED             Toggle if axe scan summary command is enabled.
# @param[in]    AXE_SCAN_SUMMARY_ADDITIONAL_PARAMTERS   Additional parameters to pass to axe-scan summary command.
##
.PHONY: axe-scan
axe-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _axe-scan

.PHONY: _axe-scan
_axe-scan:
	@echo "🧪 Performing axe scanning..."
	axe-scan --version
	axe-scan run $(AXE_SCAN_ADDITIONAL_PARAMTERS) > $(AXE_SCAN_RESULTS_CSV)
	@if [ "$(AXE_SCAN_SUMMARY_ENABLED)" = "true" ] || [ "$(AXE_SCAN_SUMMARY_ENABLED)" = "True" ] || [ "$(AXE_SCAN_SUMMARY_ENABLED)" = "t" ] || [ "$(AXE_SCAN_SUMMARY_ENABLED)" = "T" ]; then \
		axe-scan summary $(AXE_SCAN_ADDITIONAL_PARAMTERS); \
	fi
	axe-scan summary $(AXE_SCAN_ADDITIONAL_PARAMTERS)
	@echo "✅ Axe scan completed!"

##
# @function     dotnet-test
# @brief        Job for cleaning .NET project or solution (.NET Core)
# @param[in]    DOTNET_TEST_TOOL                     Tools for .NET unit testing: `xunit`, `nunit`, and `mstest`.
# @param[in]    DOTNET_TEST_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_TEST_VERBOSITY                Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    DOTNET_TEST_ADDITIONAL_FLAGS         Additional parameters to pass to `dotnet test`.
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
# @function     helm-lint
# @brief        Job for linting Helm charts
# @param[in]    HELM_CHART_PACKAGE_LINT_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_PACKAGE_LINT_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_PACKAGE_LINT_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: helm-lint
helm-lint:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-lint

.PHONY: _helm-lint
_helm-lint:
	@echo "🔨 Performing helm linting..."
	sed -i "s/helm_chart_name/$(HELM_CHART_PACKAGE_LINT_NAME)/" Chart.yaml
	helm lint $(HELM_CHART_PACKAGE_LINT_PATH) $(HELM_CHART_PACKAGE_LINT_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm linting!"

##
# @function     helm-template
# @brief        Job for validating kubernetes manifests from Helm charts
# @param[in]    HELM_CHART_PACKAGE_TEMPLATE_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_PACKAGE_TEMPLATE_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_PACKAGE_TEMPLATE_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: helm-template
helm-template:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-template

.PHONY: _helm-template
_helm-template:
	@echo "🔨 Performing helm tempalte..."
	sed -i "s/helm_chart_name/$(HELM_CHART_PACKAGE_TEMPLATE_NAME)/" Chart.yaml
	helm template $(HELM_CHART_PACKAGE_TEMPLATE_PATH) $(HELM_CHART_PACKAGE_TEMPLATE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm template!"

##
# @function     maven-validate
# @brief        Job for validating Maven configurations
# @param[in]    MAVEN_VALIDATE_PROJECT_PATH             Path where the project is located.
# @param[in]    MAVEN_VALIDATE_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_VALIDATE_ADDITIONAL_PARAMETERS    Additional parameters to pass to `mvn`.
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
# @param[in]    MAVEN_TEST_ADDITIONAL_PARAMETERS    Additional parameters to pass to `mvn`.
##
.PHONY: maven-test
maven-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-test

.PHONY: _maven-test
_maven-test:
	@echo "🧪 Performing maven test..."
	mvn $(MAVEN_TEST_VERBOSITY) test $(MAVEN_TEST_PROJECT_PATH) $(MAVEN_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed maven test!"

##
# @function     pa11y-ci-test
# @brief        Job for Pa11y accessibility scanning
# @param[in]    PA11Y_CI_CONFIG                 Path where the configuration is located.
# @param[in]    PA11Y_CI_SITEMAP                URL for the sitemap
# @param[in]    PA11Y_CI_ADDITIONAL_CONFIG      Additional parameters to pass to `pa11y-ci`.
##
.PHONY: pa11y-ci-test
pa11y-ci-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _pa11y-ci-test

.PHONY: _pa11y-ci-test
_pa11y-ci-test:
	@echo "🧪 Performing Pa11y CI Test..."
	pa11y-ci --version
	pa11y-ci --json --config $(PA11Y_CI_CONFIG) --sitemap $(PA11Y_CI_SITEMAP) $(PA11Y_CI_ADDITIONAL_CONFIG)
	@echo "✅ Completed Pa11y CI Test!"
