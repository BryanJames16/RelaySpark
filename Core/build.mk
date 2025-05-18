##
# @file         build.mk
# @brief        Build jobs for all kinds of applications.
# @author       Bryan James
# @date         2025-04-08
#
# This mk file contains job for building applications.
##

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
# @param[in]    NPM_BUILD_ADDITIONAL_PARAMETERS      Additional parameters to pass to NPM.
##
.PHONY: npm-build
npm-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-build

.PHONY: _npm-build
_npm-build:
	@echo "🔨 Performing npm build..."
	npm run build $(NPM_BUILD_DIRECTORY) $(NPM_BUILD_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed npm build!"

##
# @function     tofu-apply
# @brief        Job for applying plan files for OpenTofu.
# @param[in]    TOFU_APPLY_PLAN_FILE_NAME                 File name of OpenTofu plan file.
# @param[in]    TOFU_APPLY_ADDITIONAL_PARAMETERS          Additional parameters for apply.
##
.PHONY: tofu-apply
tofu-apply:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-apply

.PHONY: _tofu-apply
_tofu-apply:
	@echo "🔨 Performing tofu apply..."
	tofu apply -auto-approve -input=false $(TOFU_APPLY_PLAN_FILE_NAME) $(TOFU_APPLY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed tofu apply!"

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
