##
# @file         build.mk
# @brief        Build jobs for all kinds of applications.
# @author       Bryan James
# @date         2025-04-08
#
# This mk file contains job for building applications.
##

##
# @function     angular-build
# @brief        Build your Angular applications.
# @param[in]    ANGULAR_BUILD_APPLICATION_PATH                Path where the Angular application is located.
# @param[in]    ANGULAR_BUILD_CONFIGURATION                   Configuration for building your app. Default is `production`.
# @param[in]    ANGULAR_BUILD_OUTPUT_PATH                     Output path where the application will be built.
# @param[in]    ANGULAR_BUILD_ADDITIONAL_PARAMETERS           Additional `ng build` parameters.
##
.PHONY: angular-build
angular-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _angular-build

.PHONY: _angular-build
_angular-build:
	@echo "🔨 Performing Go build..."
	cd $(ANGULAR_BUILD_APPLICATION_PATH)
	ng build --configuration $(ANGULAR_BUILD_CONFIGURATION) --output-path=$(ANGULAR_BUILD_OUTPUT_PATH) $(ANGULAR_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed Go build!"

##
# @function     cargo-build
# @brief        Build Rust applications through cargo.
# @param[in]    CARGO_BUILD_MANIFEST_PATH                Path where Cargo.toml is located.
# @param[in]    CARGO_BUILD_ADDITIONAL_PARAMETERS        Additional build parameters for cargo build.
##
.PHONY: cargo-build
cargo-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cargo-build

.PHONY: _cargo-build
_cargo-build:
	@echo "🔨 Performing cargo build..."
	cargo build --release --manifest-path $(CARGO_BUILD_MANIFEST_PATH) $(CARGO_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed cargo build!"

##
# @function     docker-build
# @brief        Job for building container images using Docker.
# @param[in]    CONTAINER_BUILD_IMAGE_NAME               The full container image name.
# @param[in]    CONTAINER_BUILD_IMAGE_TAG                Tag of the container image to use.
# @param[in]    DOCKERFILE_PATH                          Path of the Dockerfile.
# @param[in]    CONTAINER_BUILD_ADDITIONAL_PARAMETERS    Additional docker build parameters.
##
.PHONY: docker-build
docker-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _docker-build

.PHONY: _docker-build
_docker-build:
	@echo "🔨 Performing docker build..."
	docker build -t $(CONTAINER_BUILD_IMAGE_NAME):$(CONTAINER_BUILD_IMAGE_TAG) $(DOCKERFILE_PATH) $(CONTAINER_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed docker build!"

##
# @function     dotnet-build
# @brief        Job for building .NET application (.NET Core).
# @param[in]    DOTNET_BUILD_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_BUILD_VERBOSITY                Verbosity of the command output. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
# @param[in]    DOTNET_BUILD_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: dotnet-build
dotnet-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-build

.PHONY: _dotnet-build
_dotnet-build:
	@echo "🔨 Performing dotnet build..."
	dotnet build $(DOTNET_BUILD_SP_PATH) -v $(DOTNET_BUILD_VERBOSITY) $(DOTNET_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed dotnet build!"

##
# @function     go-build
# @brief        Build your Go module(s) and application(s).
# @param[in]    GO_BUILD_APPLICATION_PATH                Path where the Go application is located.
# @param[in]    GO_BUILD_OUTPUT_PATH                     Output path where the application will be built.
# @param[in]    GO_BUILD_ADDITIONAL_PARAMETERS           Additional go build parameters.
##
.PHONY: go-build
go-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _go-build

.PHONY: _go-build
_go-build:
	@echo "🔨 Performing Go build..."
	go build -o $(GO_BUILD_OUTPUT_PATH) $(GO_BUILD_APPLICATION_PATH) $(GO_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed Go build!"

##
# @function     kaniko-build
# @brief        Job for building container images using Kaniko.
# @param[in]    KANIKO_BUILD_IMAGE_NAME                  The full container image name.
# @param[in]    KANIKO_BUILD_IMAGE_TAG                   Tag of the container image to use.
# @param[in]    KANIKO_DOCKER_AUTH_CONFIG_ENABLED        Enable seeding of remote authentication credentials.
# @param[in]    KANIKO_DOCKER_AUTH_CONFIG                Docker authentication configuration.
# @param[in]    KANIKO_DOCKERFILE_PATH                   Full path and filename of the Dockerfile.
# @param[in]    KANIKO_BUILD_PROJECT_DIR                 Path of the project directory.
# @param[in]    KANIKO_BUILD_ADDITIONAL_PARAMETERS       Additional kaniko build parameters.
##
.PHONY: kaniko-build
kaniko-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _kaniko-build

.PHONY: _kaniko-build
_kaniko-build:
	@if [ "$(KANIKO_DOCKER_AUTH_CONFIG_ENABLED)" = "true" ] || [ "$(KANIKO_DOCKER_AUTH_CONFIG_ENABLED)" = "True" ] || [ "$(KANIKO_DOCKER_AUTH_CONFIG_ENABLED)" = "t" ] || [ "$(KANIKO_DOCKER_AUTH_CONFIG_ENABLED)" = "T" ]; then \
		echo "🔑 Seeding remote authentication credentials..."; \
		echo $(KANIKO_DOCKER_AUTH_CONFIG) > /kaniko/.docker/config.json; \
		echo "✅ Completed seeding remote authentication credentials!"; \
	fi
	@echo "🔨 Performing kaniko build..."
	/kaniko/executor \
		--context $(KANIKO_BUILD_PROJECT_DIR) \
		--dockerfile $(KANIKO_DOCKERFILE_PATH) \
		--tarPath ${KANIKO_BUILD_PROJECT_DIR}/app_image.tar \
		--destination $(KANIKO_BUILD_IMAGE_NAME):$(KANIKO_BUILD_IMAGE_TAG) \
		--no-push \
		$(KANIKO_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed kaniko build!"

##
# @function     maven-compile
# @brief        Job for building Maven-based application.
# @param[in]    MAVEN_BUILD_PROJECT_PATH             Path where the project is located.
# @param[in]    MAVEN_BUILD_VERBOSITY                Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_BUILD_ADDITIONAL_PARAMETERS    Additional parameters to pass to maven.
##
.PHONY: maven-compile
maven-compile:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-compile

.PHONY: _maven-compile
_maven-compile:
	@echo "🔨 Performing maven compile..."
	mvn $(MAVEN_BUILD_VERBOSITY) compile $(MAVEN_BUILD_PROJECT_PATH) $(MAVEN_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed maven compile!"

##
# @function     npm-build
# @brief        Build node application.
# @param[in]    NPM_BUILD_DIRECTORY                  Path where the project is located.
# @param[in]    NPM_BUILD_INSTALL_ADDITIONAL_PARAMETERS          Additional parameters to pass to npm install.
# @param[in]    NPM_BUILD_ADDITIONAL_PARAMETERS      Additional parameters to pass to NPM.
##
.PHONY: npm-build
npm-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-build

.PHONY: _npm-build
_npm-build:
	@echo "🔨 Performing npm build..."
	npm version
	npm install $(NPM_BUILD_DIRECTORY) $(NPM_BUILD_INSTALL_ADDITIONAL_PARAMETERS)
	npm run build $(NPM_BUILD_DIRECTORY) $(NPM_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed npm build!"

##
# @function     npm-clean-build
# @brief        Performs npm clean install on your application.
# @param[in]    NPM_CLEAN_BUILD_DIRECTORY                  Path where the project is located.
# @param[in]    NPM_CLEAN_BUILD_INSTALL_ADDITIONAL_PARAMETERS      Additional parameters to pass to npm clean install.
# @param[in]    NPM_CLEAN_BUILD_ADDITIONAL_PARAMETERS      Additional parameters to pass to NPM.
##
.PHONY: npm-clean-build
npm-clean-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-clean-build

.PHONY: _npm-clean-build
_npm-clean-build:
	@echo "🔨 Performing npm clean build..."
	npm version
	npm clean-install $(NPM_CLEAN_BUILD_DIRECTORY) $(NPM_CLEAN_BUILD_INSTALL_ADDITIONAL_PARAMETERS)
	npm run build $(NPM_CLEAN_BUILD_DIRECTORY) $(NPM_CLEAN_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed npm clean build!"

##
# @function     terraform-plan
# @brief        Job for building Terraform plan file.
# @param[in]    TERRAFORM_PLAN_PLAN_FILE_NAME                 File name of Terraform plan file.
# @param[in]    TERRAFORM_PLAN_ADDITIONAL_PARAMETERS          Additional parameters for plan.
##
.PHONY: terraform-plan
terraform-plan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _terraform-plan

.PHONY: _terraform-plan
_terraform-plan:
	@echo "🔨 Performing terraform plan..."
	tofu plan -out="$(TERRAFORM_PLAN_PLAN_FILE_NAME)" $(TERRAFORM_PLAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed terraform plan!"

##
# @function     terraform-apply
# @brief        Job for applying plan files for Terraform.
# @param[in]    TERRAFORM_APPLY_PLAN_FILE_NAME                 File name of Terraform plan file.
# @param[in]    TERRAFORM_APPLY_ADDITIONAL_PARAMETERS          Additional parameters for apply.
##
.PHONY: terraform-apply
terraform-apply:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _terraform-apply

.PHONY: _terraform-apply
_terraform-apply:
	@echo "🔨 Performing terraform apply..."
	terraform apply -auto-approve -input=false $(TERRAFORM_APPLY_PLAN_FILE_NAME) $(TERRAFORM_APPLY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed terraform apply!"

##
# @function     tofu-plan
# @brief        Job for building OpenTofu plan file.
# @param[in]    TOFU_PLAN_PLAN_FILE_NAME                 File name of OpenTofu plan file.
# @param[in]    TOFU_PLAN_ADDITIONAL_PARAMETERS          Additional parameters for plan.
##
.PHONY: tofu-plan
tofu-plan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-plan

.PHONY: _tofu-plan
_tofu-plan:
	@echo "🔨 Performing tofu plan..."
	tofu plan -out="$(TOFU_PLAN_PLAN_FILE_NAME)" $(TOFU_PLAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed tofu plan!"
