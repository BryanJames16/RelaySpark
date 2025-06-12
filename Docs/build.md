# 🛠️ Pipeline Build Jobs

## 🔨 angular-build
Build your Angular applications.

### 🗃️ Variables
- `ANGULAR_BUILD_APPLICATION_PATH`: Path where the Angular application is located.
- `ANGULAR_BUILD_CONFIGURATION`: Configuration for building your app. Default is `production`.
- `ANGULAR_BUILD_OUTPUT_PATH`: Output path where the application will be built.
- `ANGULAR_BUILD_ADDITIONAL_PARAMETERS`: Additional `ng build` parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make angular-build

# Job Call
make _angular-build
```

### 🕶️ Requirements
- Container image with `angular` installed.

---

## 🔨 cargo-build
Build Rust applications through cargo.

### 🗃️ Variables
- `CARGO_BUILD_MANIFEST_PATH`: Path where Cargo.toml is located.
- `CONTAINER_BUILD_ADDITIONAL_PARAMETERS`: Additional build parameters for cargo build.

### 💻 Command
```Shell
# Via docker compose wrapper
make cargo-build

# Job Call
make _cargo-build
```

### 🕶️ Requirements
- Container image with `rust` and `cargo` installed.

---

## 🔨 docker-build
Job for building container images using Docker.

### 🗃️ Variables
- `CONTAINER_IMAGE_NAME`: The full container image name.
- `CONTAINER_IMAGE_TAG`: Tag of the container image to use.
- `DOCKERFILE_PATH`: Path of the `Dockerfile`.
- `CONTAINER_BUILD_ADDITIONAL_PARAMETERS`: Additional docker build parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make docker-build

# Job Call
make _docker-build
```

### 🕶️ Requirements
- Container image with docker (DinD).

---

## 🔨 dotnet-build
Job for building .NET application (.NET Core).

### 🗃️ Variables
- `DOTNET_BUILD_SP_PATH`: Path where the project or the solution file is placed.
- `DOTNET_BUILD_VERBOSITY`: Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
- `DOTNET_BUILD_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `dotnet build`.

### 💻 Command
```Shell
# Via docker compose wrapper
make dotnet-build

# Job Call
make _dotnet-build
```

### 🕶️ Requirements
- Container image with a .NET SDK.

---

## 🔨 go-build
Build your Go module(s) and application(s).

### 🗃️ Variables
- `GO_BUILD_APPLICATION_PATH`: Path where the Go application is located.
- `GO_BUILD_OUTPUT_PATH`: Output path where the application will be built.
- `GO_BUILD_ADDITIONAL_PARAMETERS`: Additional go build parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make go-build

# Job Call
make _go-build
```

### 🕶️ Requirements
- Container image with `go` installed.

---

## 🔨 kaniko-build
Job for building container images using Kaniko executor.

### 🗃️ Variables
- `KANIKO_BUILD_IMAGE_NAME`: The full container image name.
- `KANIKO_BUILD_IMAGE_TAG`: Tag of the container image to use.
- `KANIKO_DOCKER_AUTH_CONFIG_ENABLED`: Enable seeding of remote authentication credentials.
- `KANIKO_DOCKER_AUTH_CONFIG`: Docker authentication configuration.
- `KANIKO_DOCKERFILE_PATH` : Full path and filename of the Dockerfile.
- `KANIKO_BUILD_PROJECT_DIR` : Path of the project directory.
- `KANIKO_BUILD_ADDITIONAL_PARAMETERS` : Additional kaniko build parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make kaniko-build

# Job Call
make _kaniko-build
```

### 🕶️ Requirements
- Container image with Kaniko executor.

---

## 🔨 maven-compile
Job for building Maven-based application.

### 🗃️ Variables
- `MAVEN_BUILD_PROJECT_PATH`: Path where the project is located.
- `MAVEN_BUILD_VERBOSITY`: Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
- `MAVEN_BUILD_ADDITIONAL_PARAMETERS`: Additional parameters to pass to maven.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-compile

# Job Call
make _maven-compile
```

### 🕶️ Requirements
- Container image with maven installed.
- Any maven dependencies (java, compiler, toolchains, etc...).

---

## 🔨 npm-build
Build node applications.

### 🗃️ Variables
- `NPM_BUILD_DIRECTORY`: Path where the project is located.
- `NPM_BUILD_INSTALL_ADDITIONAL_PARAMETERS`: Additional parameters to pass to npm install.
- `NPM_BUILD_ADDITIONAL_PARAMETERS`: Additional parameters to pass to NPM.

### 💻 Command
```Shell
# Via docker compose wrapper
make npm-build

# Job Call
make _npm-build
```

### 🕶️ Requirements
- Container image with NodeJS installed, particularly `npm` command.

---

## 🔨 npm-clean-build
Performs npm clean install on your application.

### 🗃️ Variables
- `NPM_CLEAN_BUILD_DIRECTORY`: Path where the project is located.
- `NPM_CLEAN_BUILD_INSTALL_ADDITIONAL_PARAMETERS`: Additional parameters to pass to npm clean install.
- `NPM_CLEAN_BUILD_ADDITIONAL_PARAMETERS`: Additional parameters to pass to NPM.

### 💻 Command
```Shell
# Via docker compose wrapper
make npm-clean-build

# Job Call
make _npm-clean-build
```

### 🕶️ Requirements
- Container image with NodeJS installed, particularly `npm` command.

---

## 🔨 terraform-plan
Job for building Terraform plan file.

### 🗃️ Variables
- `TERRAFORM_PLAN_PLAN_FILE_NAME`: File name of Terraform plan file.
- `TERRAFORM_PLAN_ADDITIONAL_PARAMETERS`: Additional parameters for plan.

### 💻 Command
```Shell
# Via docker compose wrapper
make terraform-plan

# Job Call
make _terraform-plan
```

### 🕶️ Requirements
- Container image with Terraform installed, specifically `terraform` command.

---

## 🔨 terraform-apply
Job for applying plan files for Terraform.

### 🗃️ Variables
- `TERRAFORM_APPLY_PLAN_FILE_NAME`: File name of Terraform plan file.
- `TERRAFORM_APPLY_ADDITIONAL_PARAMETERS`: Additional parameters for apply.

### 💻 Command
```Shell
# Via docker compose wrapper
make terraform-apply

# Job Call
make _terraform-apply
```

### 🕶️ Requirements
- Container image with Terraform installed, specifically `terraform` command.

---

## 🔨 tofu-apply
Job for applying plan files for OpenTofu.

### 🗃️ Variables
- `TOFU_APPLY_PLAN_FILE_NAME`: File name of OpenTofu plan file.
- `TOFU_APPLY_ADDITIONAL_PARAMETERS`: Additional parameters for apply.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-apply

# Job Call
make _tofu-apply
```

### 🕶️ Requirements
- Container image with OpenTofu installed, specifically `tofu` command.

---

## 🔨 tofu-plan
Job for building OpenTofu plan file.

### 🗃️ Variables
- `TOFU_PLAN_PLAN_FILE_NAME`: File name of OpenTofu plan file.
- `TOFU_PLAN_ADDITIONAL_PARAMETERS`: Additional parameters for plan.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-plan

# Job Call
make _tofu-plan
```

### 🕶️ Requirements
- Container image with OpenTofu installed, specifically `tofu` command.
