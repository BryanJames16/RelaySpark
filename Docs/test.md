# 🧪 Pipeline Test Jobs

## 🧪 angular-lint
Perform linting of Angular application.

### 🗃️ Variables
- `ANGULAR_LINT_APP_PATH`: Path of your Angular application.
- `ANGULAR_LINT_ADDITIONAL_PARAMETERS`: Additional parameters for `ng lint`.

### 💻 Command
```Shell
# Via docker compose wrapper
make angular-lint

# Job Call
make _angular-lint
```

### 🕶️ Requirements
- Container image with angular installed.

---

## 🧪 angular-test
Perform unit testing of Angular application.

### 🗃️ Variables
- `ANGULAR_TEST_APP_PATH`: Path of your Angular application.
- `ANGULAR_TEST_ENABLE_FILE_WATCHING`: Enable file watching during ng test. Default is `false`.
- `ANGULAR_TEST_ADDITIONAL_PARAMETERS`: Additional parameters for `ng test`.

### 💻 Command
```Shell
# Via docker compose wrapper
make angular-test

# Job Call
make _angular-test
```

### 🕶️ Requirements
- Container image with angular installed.

---

## 🧪 axe-scan
Job for scanning accessibility violations via axe-scan.

### 🗃️ Variables
- `AXE_SCAN_RESULTS_CSV`: CSV file for Axe Scan results.
- `AXE_SCAN_ADDITIONAL_PARAMTERS`: Additional parameters to pass to axe-scan run command.
- `AXE_SCAN_SUMMARY_ENABLED`: Toggle if axe scan summary command is enabled.
- `AXE_SCAN_SUMMARY_ADDITIONAL_PARAMTERS`: Additional parameters to pass to axe-scan summary command.

### 💻 Command
```Shell
# Via docker compose wrapper
make axe-scan

# Job Call
make _axe-scan
```

### 🕶️ Requirements
- Container image with axe-scan installed.

---

## 🧪 cargo-test
Validate rust package and application. Performs formatting, linting, and checking.

### 🗃️ Variables
- `CARGO_TEST_APP_PATH`: Path where the rust application Config.toml resides.
- `CARGO_TEST_ADDITIONAL_PARAMETERS`: Additional parameters for cargo test.

### 💻 Command
```Shell
# Via docker compose wrapper
make cargo-test

# Job Call
make _cargo-test
```

### 🕶️ Requirements
- Container image with `rust` and `cargo` installed.

---

## 🧪 cargo-validate
Validate rust package and application. Performs formatting, linting, and checking.

### 🗃️ Variables
- `CARGO_VALIDATE_APP_PATH`: Path where the rust application Config.toml resides.
- `CARGO_VALIDATE_FMT_ADDITIONAL_PARAMETERS`: Additional parameters for cargo fmt.
- `CARGO_VALIDATE_CHECK_ADDITIONAL_PARAMETERS`: Additional parameters for cargo check.
- `CARGO_VALIDATE_CLIPPY_ADDITIONAL_PARAMETERS`: Additional parameters for cargo clippy.

### 💻 Command
```Shell
# Via docker compose wrapper
make cargo-validate

# Job Call
make _cargo-validate
```

### 🕶️ Requirements
- Container image with `rust` and `cargo` installed.

---

## 🧪 dotnet-test
Job for cleaning .NET project or solution (.NET Core).

### 🗃️ Variables
- `DOTNET_TEST_TOOL`: Tools for .NET unit testing: `xunit`, `nunit`, and `mstest`.
- `DOTNET_TEST_SP_PATH`: Additional parameters to pass to axe-scan run command.
- `DOTNET_TEST_VERBOSITY`: Toggle if axe scan summary command is enabled.
- `DOTNET_TEST_ADDITIONAL_PARAMETERS`: Additional parameters to pass to axe-scan summary command.

### 💻 Command
```Shell
# Via docker compose wrapper
make dotnet-test

# Job Call
make _dotnet-test
```

### 🕶️ Requirements
- Container image with .NET SDK installed.

---

## 🧪 go-test
Go unit testing job. This job performs `go test` and `go tool cover` commands when executed.

### 🗃️ Variables
- `GO_TEST_APPLICATION_PATH`: Application path for your Go application / modules.
- `GO_TEST_COVER_PROFILE`: Cover profile for your test.
- `GO_TEST_TOOL_COVER_OUTPUT`: Generation of your coverge profile for output.
- `GO_TEST_ADDITIONAL_PARAMETERS`: Additional parameters for `go test`.
- `GO_TEST_TOOL_COVER_ADDITIONAL_PARAMETERS`: Additional parameters for `go tool cover`.

### 💻 Command
```Shell
# Via docker compose wrapper
make go-test

# Job Call
make _go-test
```

### 🕶️ Requirements
- Container image with `go` installed.

---

## 🧪 helm-lint
Job for linting Helm charts.

### 🗃️ Variables
- `HELM_CHART_LINT_PATH`: Path where the helm chart is located.
- `HELM_CHART_LINT_NAME`: The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
- `HELM_CHART_LINT_ADDITIONAL_PARAMETERS`: Additional parameters to pass to command.

### 💻 Command
```Shell
# Via docker compose wrapper
make helm-lint

# Job Call
make _helm-lint
```

### 🕶️ Requirements
- Container image with helm installed.
- Set the Helm Chart name inside `Chart.yaml` to `helm_chart_name` for a variable input to be overwritten during job runtime.

---

## 🧪 helm-template
Job for validating kubernetes manifests from Helm charts.

### 🗃️ Variables
- `HELM_CHART_TEMPLATE_PATH`: Path where the helm chart is located.
- `HELM_CHART_TEMPLATE_NAME`: The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
- `HELM_CHART_TEMPLATE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to command.

### 💻 Command
```Shell
# Via docker compose wrapper
make helm-template

# Job Call
make _helm-template
```

### 🕶️ Requirements
- Container image with helm installed.
- Set the Helm Chart name inside `Chart.yaml` to `helm_chart_name` for a variable input to be overwritten during job runtime.

---

## 🧪 helm-test
Job for testing Helm charts.

### 🗃️ Variables
- `HELM_CHART_TEST_PATH`: Path where the helm chart is located.
- `HELM_CHART_TEST_NAME`: The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
- `HELM_CHART_TEST_NAMESPACE`: Namespace where the helm chart wil be installed.
- `HELM_CHART_TEST_ADDITIONAL_PARAMETERS`: Additional parameters to pass to command.

### 💻 Command
```Shell
# Via docker compose wrapper
make helm-test

# Job Call
make _helm-test
```

### 🕶️ Requirements
- Container image with helm installed.
- Set the Helm Chart name inside `Chart.yaml` to `helm_chart_name` for a variable input to be overwritten during job runtime.

---

## 🧪 yaml-schema-lint
Job for linting yaml schema.

### 🗃️ Variables
- `YAML_SCHEMA_LINT_SCHEMA_PATH`: Full path and file name of schema file.
- `YAML_SCHEMA_LINT_SCAN_PATH`: Full path and file name of the YAML file to be scanned.
- `YAML_SCHEMA_LINT_ADDITIONAL_PARAMETERS`: Additional parameters for scanning through yamale.

### 💻 Command
```Shell
# Via docker compose wrapper
make yaml-schema-lint

# Job Call
make _yaml-schema-lint
```

### 🕶️ Requirements
- Container image with yamale installed.

---

## 🧪 maven-validate
Job for validating Maven configurations.

### 🗃️ Variables
- `MAVEN_VALIDATE_PROJECT_PATH`: Path where the project is located.
- `MAVEN_VALIDATE_VERBOSITY`: Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
- `MAVEN_VALIDATE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `mvn`.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-validate

# Job Call
make _maven-validate
```

### 🕶️ Requirements
- Container image with maven installed.

---

## 🧪 maven-test
Job for validating Maven configurations.

### 🗃️ Variables
- `MAVEN_TEST_PROJECT_PATH`: Path where the project is located.
- `MAVEN_TEST_VERBOSITY`: Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
- `MAVEN_TEST_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `mvn`.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-test

# Job Call
make _maven-test
```

### 🕶️ Requirements
- Container image with maven installed.

---

## 🧪 npm-test
Perform NPM tests for node applications.

### 🗃️ Variables
- `NPM_TEST_ADDITIONAL_PARAMETERS`: Additional parameters to pass to npm test command.

### 💻 Command
```Shell
# Via docker compose wrapper
make npm-test

# Job Call
make _npm-test
```

### 🕶️ Requirements
- Container image with `npm` and `node` installed.

---

## 🧪 pa11y-ci-test
Job for Pa11y accessibility scanning.

### 🗃️ Variables
- `PA11Y_CI_CONFIG`: Path where the configuration is located.
- `PA11Y_CI_SITEMAP`: URL for the sitemap.
- `PA11Y_CI_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `pa11y-ci`.

### 💻 Command
```Shell
# Via docker compose wrapper
make pa11y-ci-test

# Job Call
make _pa11y-ci-test
```

### 🕶️ Requirements
- Container image with pa11y-ci installed.

---

## 🧪 terraform-validate
OpenTofu validation command.

### 🗃️ Variables
- `TERRAFORM_VALIDATE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to Terraform validate.

### 💻 Command
```Shell
# Via docker compose wrapper
make terraform-validate

# Job Call
make _terraform-validate
```

### 🕶️ Requirements
- Container image with Terraform installed.

---

## 🧪 tofu-validate
OpenTofu validation command.

### 🗃️ Variables
- `TOFU_VALIDATE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to OpenTofu validate.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-validate

# Job Call
make _tofu-validate
```

### 🕶️ Requirements
- Container image with OpenTofu installed.
