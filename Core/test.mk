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
# @function     angular-lint
# @brief        Perform linting of Angular application.
# @param[in]    ANGULAR_LINT_APP_PATH                           Path of your Angular application.
# @param[in]    ANGULAR_LINT_ADDITIONAL_PARAMETERS              Additional parameters for `ng lint`.
##
.PHONY: angular-lint
angular-lint:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _angular-lint

.PHONY: _angular-lint
_angular-lint:
	@echo "🧪 Performing Angular lint..."
	cd $(ANGULAR_LINT_APP_PATH)
	ng lint $(ANGULAR_LINT_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed angular linting!"

##
# @function     angular-test
# @brief        Perform unit testing of Angular application.
# @param[in]    ANGULAR_TEST_APP_PATH                           Path of your Angular application.
# @param[in]    ANGULAR_TEST_ENABLE_FILE_WATCHING               Enable file watching during ng test. Default is `false`.
# @param[in]    ANGULAR_TEST_ADDITIONAL_PARAMETERS              Additional parameters for `ng test`.
##
.PHONY: angular-test
angular-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _angular-test

.PHONY: _angular-test
_angular-test:
	@echo "🧪 Performing Angular unit testing..."
	cd $(ANGULAR_TEST_APP_PATH)
	ng test --code-coverage --watch=$(ANGULAR_TEST_ENABLE_FILE_WATCHING) $(ANGULAR_LINT_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed angular unit testing!"

##
# @function     axe-scan
# @brief        Job for scanning accessibility violations via axe-scan.
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
# @function     cargo-test
# @brief        Perform rust unit testing.
# @param[in]    CARGO_TEST_APP_PATH                             Path where the rust application Config.toml resides.
# @param[in]    CARGO_TEST_ADDITIONAL_PARAMETERS                Additional parameters for cargo test.
##
.PHONY: cargo-test
cargo-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cargo-test

.PHONY: _cargo-test
_cargo-test:
	@echo "🧪 Performing rust unit testing..."
	cargo test --manifest-path $(CARGO_TEST_APP_PATH) $(CARGO_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed rust unit testing!"

##
# @function     cargo-validate
# @brief        Validate rust package and application. Performs formatting, linting, and checking.
# @param[in]    CARGO_VALIDATE_APP_PATH                         Path where the rust application Config.toml resides.
# @param[in]    CARGO_VALIDATE_FMT_ADDITIONAL_PARAMETERS        Additional parameters for cargo fmt.
# @param[in]    CARGO_VALIDATE_CHECK_ADDITIONAL_PARAMETERS      Additional parameters for cargo check.
# @param[in]    CARGO_VALIDATE_CLIPPY_ADDITIONAL_PARAMETERS     Additional parameters for cargo clippy.
##
.PHONY: cargo-validate
cargo-validate:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cargo-validate

.PHONY: _cargo-validate
_cargo-validate:
	@echo "🧪 Performing rust (cargo) validation..."
	cargo fmt --manifest-path $(CARGO_VALIDATE_APP_PATH) $(CARGO_VALIDATE_FMT_ADDITIONAL_PARAMETERS)
	cargo check --manifest-path $(CARGO_VALIDATE_APP_PATH) $(CARGO_VALIDATE_CHECK_ADDITIONAL_PARAMETERS)
	cargo clippy --manifest-path $(CARGO_VALIDATE_APP_PATH) $(CARGO_VALIDATE_CLIPPY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed rust (cargo) validation!"

##
# @function     dotnet-test
# @brief        Job for cleaning .NET project or solution (.NET Core).
# @param[in]    DOTNET_TEST_TOOL                     Tools for .NET unit testing: `xunit`, `nunit`, and `mstest`.
# @param[in]    DOTNET_TEST_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_TEST_VERBOSITY                Verbosity of the command output. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
# @param[in]    DOTNET_TEST_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet test`.
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
	dotnet test $(DOTNET_TEST_SP_PATH) -v $(DOTNET_TEST_VERBOSITY) $(DOTNET_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Unit test completed!"

##
# @function     go-test
# @brief        Go unit testing job.
# @param[in]    GO_TEST_APPLICATION_PATH                             Application path for your Go application / modules.
# @param[in]    GO_TEST_COVER_PROFILE                                Cover profile for your test.
# @param[in]    GO_TEST_TOOL_COVER_OUTPUT                            Generation of your coverge profile for output.
# @param[in]    GO_TEST_ADDITIONAL_PARAMETERS                        Additional parameters for `go test`.
# @param[in]    GO_TEST_TOOL_COVER_ADDITIONAL_PARAMETERS             Additional parameters for `go tool cover`.
##
.PHONY: go-test
go-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _go-test

.PHONY: _go-test
_go-test:
	@echo "🧪 Performing go unit testing..."
	go test -v -coverprofile=$(GO_TEST_COVER_PROFILE) $(GO_TEST_APPLICATION_PATH) $(GO_TEST_ADDITIONAL_PARAMETERS)
	go tool cover $(GO_TEST_TOOL_COVER_OUTPUT) $(GO_TEST_TOOL_COVER_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed go unit testing!"

##
# @function     helm-lint
# @brief        Job for linting Helm charts.
# @param[in]    HELM_CHART_LINT_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_LINT_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_LINT_ADDITIONAL_PARAMETERS    Additional parameters to pass to command.
##
.PHONY: helm-lint
helm-lint:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-lint

.PHONY: _helm-lint
_helm-lint:
	@echo "🧪 Performing helm linting..."
	sed -i "s/helm_chart_name/$(HELM_CHART_LINT_NAME)/" Chart.yaml
	helm lint $(HELM_CHART_LINT_PATH) $(HELM_CHART_LINT_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm linting!"

##
# @function     helm-template
# @brief        Job for validating kubernetes manifests from Helm charts.
# @param[in]    HELM_CHART_TEMPLATE_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_TEMPLATE_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_TEMPLATE_ADDITIONAL_PARAMETERS    Additional parameters to pass to comamnd.
##
.PHONY: helm-template
helm-template:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-template

.PHONY: _helm-template
_helm-template:
	@echo "🧪 Performing helm tempalte..."
	sed -i "s/helm_chart_name/$(HELM_CHART_TEMPLATE_NAME)/" Chart.yaml
	helm template $(HELM_CHART_TEMPLATE_PATH) $(HELM_CHART_TEMPLATE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm template!"

##
# @function     helm-test
# @brief        Job for testing Helm charts.
# @param[in]    HELM_CHART_TEST_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_TEST_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_TEST_NAMESPACE            Namespace where the helm chart wil be installed.
# @param[in]    HELM_CHART_TEST_ADDITIONAL_PARAMETERS    Additional parameters to pass to command.
##
.PHONY: helm-test
helm-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-test

.PHONY: _helm-test
_helm-test:
	@echo "🧪 Performing helm test..."
	sed -i "s/helm_chart_name/$(HELM_CHART_TEST_NAME)/" Chart.yaml
	helm install $(HELM_CHART_TEST_NAME) $(HELM_CHART_TEST_PATH) --namespace $(HELM_CHART_TEST_NAMESPACE)
	helm test $(HELM_CHART_TEST_PATH) $(HELM_CHART_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm test!"

##
# @function     yaml-schema-lint
# @brief        Job for linting yaml schema.
# @param[in]    YAML_SCHEMA_LINT_SCHEMA_PATH                 Full path and file name of schema file.
# @param[in]    YAML_SCHEMA_LINT_SCAN_PATH                   Full path and file name of the YAML file to be scanned.
# @param[in]    YAML_SCHEMA_LINT_ADDITIONAL_PARAMETERS       Additional parameters for scanning through yamale.
##
.PHONY: yaml-schema-lint
helm-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _yaml-schema-lint

.PHONY: _yaml-schema-lint
_yaml-schema-lint:
	@echo "🧪 Performing YAML schema linting..."
	yamale --schema $(YAML_SCHEMA_LINT_SCHEMA_PATH) $(YAML_SCHEMA_LINT_ADDITIONAL_PARAMETERS) $(YAML_SCHEMA_LINT_SCAN_PATH)
	@echo "✅ Completed YAML schema lint!"

##
# @function     maven-validate
# @brief        Job for validating Maven configurations.
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
# @function     npm-test
# @brief        Perform NPM tests for node applications.
# @param[in]    NPM_TEST_ADDITIONAL_PARAMETERS      Additional parameters to pass to npm test command.
##
.PHONY: npm-test
npm-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-test

.PHONY: _npm-test
_npm-test:
	@echo "🧪 Performing NPM test..."
	npm test $(NPM_TEST_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed NPM test!"

##
# @function     pa11y-ci-test
# @brief        Job for Pa11y accessibility scanning.
# @param[in]    PA11Y_CI_CONFIG                 Path where the configuration is located.
# @param[in]    PA11Y_CI_SITEMAP                URL for the sitemap.
# @param[in]    PA11Y_CI_ADDITIONAL_PARAMETERS  Additional parameters to pass to `pa11y-ci`.
##
.PHONY: pa11y-ci-test
pa11y-ci-test:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _pa11y-ci-test

.PHONY: _pa11y-ci-test
_pa11y-ci-test:
	@echo "🧪 Performing Pa11y CI Test..."
	pa11y-ci --version
	pa11y-ci --json --config $(PA11Y_CI_CONFIG) --sitemap $(PA11Y_CI_SITEMAP) $(PA11Y_CI_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed Pa11y CI Test!"

##
# @function     terraform-validate
# @brief        Terraform validation command.
# @param[in]    TERRAFORM_VALIDATE_ADDITIONAL_PARAMETERS  Additional parameters to pass to Terraform validate.
##
.PHONY: terraform-validate
terraform-validate:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _terraform-validate

.PHONY: _terraform-validate
_terraform-validate:
	@echo "🧪 Performing Terraform validation..."
	terraform validate $(TERRAFORM_VALIDATE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed Terraform validation!"

##
# @function     tofu-validate
# @brief        OpenTofu validation command.
# @param[in]    TOFU_VALIDATE_ADDITIONAL_PARAMETERS  Additional parameters to pass to OpenTofu validate.
##
.PHONY: tofu-validate
tofu-validate:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-validate

.PHONY: _tofu-validate
_tofu-validate:
	@echo "🧪 Performing OpenTofu validation..."
	tofu validate $(TOFU_VALIDATE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed OpenTofu validation!"
