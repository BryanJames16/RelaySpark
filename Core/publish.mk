##
# @file publish.mk
# @brief All pipeline jobs for publishing.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains jobs for publishing artifacts.
# These jobs doesn't deploy to any active environments.
##

##
# @function     dotnet-publish
# @brief        Job for cleaning .NET project or solution (.NET Core)
# @param[in]    DOTNET_PUBLISH_SP_PATH               Path where the project or the solution file is placed.
# @param[in]    DOTNET_PUBLISH_OUTPUT_PATH           Output directory where the binaries will be stored
# @param[in]    DOTNET_PUBLISH_VERBOSITY             Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    DOTNET_PUBLISH_ADDITIONAL_FLAGS      Additional parameters to pass to `dotnet clean`.
##
.PHONY: dotnet-publish
dotnet-publish:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-publish

.PHONY: _dotnet-publish
_dotnet-publish:
	@echo "📜 Building and publishing dotnet application..."
	dotnet publish $(DOTNET_PUBLISH_SP_PATH) --output $(DOTNET_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_PUBLISH_VERBOSITY) $(DOTNET_PUBLISH_ADDITIONAL_FLAGS)
	@echo "✅ Build and publish done!"

##
# @function     helm-package
# @brief        Job for packaging Helm charts
# @param[in]    HELM_CHART_PACKAGE_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_PACKAGE_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_PACKAGE_VERSION              Version of the helm chart,
# @param[in]    HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: helm-package
helm-package:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-package

.PHONY: _helm-package
_helm-package:
	@echo "🔨 Performing helm package..."
	sed -i "s/helm_chart_name/$(HELM_CHART_PACKAGE_NAME)/" Chart.yaml
	helm package $(HELM_CHART_PACKAGE_PATH) --version $(HELM_CHART_PACKAGE_VERSION) $(HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed helm package!"
	@echo "🔨 Performing post-packaging verification..."
	helm inspect chart $(HELM_CHART_PACKAGE_PATH)-*.tgz
	@echo "✅ Completed post-packaging verification!"

##
# @function     maven-package
# @brief        Job for packaging maven projects
# @param[in]    MAVEN_PACKAGE_PROJECT_PATH             Path where the project is placed.
# @param[in]    MAVEN_PACKAGE_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_PACKAGE_ADDITIONAL_PARAMETERS    Additional parameters to pass to maven.
##
.PHONY: maven-package
maven-package:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-package

.PHONY: _maven-package
_maven-package:
	@echo "📦 Packaging your maven application..."
	mvn $(MAVEN_PACKAGE_VERBOSITY) package $(MAVEN_PACKAGE_PROJECT_PATH) $(MAVEN_PACKAGE_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed packaging your maven application!"

##
# @function     maven-deploy
# @brief        Job for deploying maven projects
# @param[in]    MAVEN_DEPLOY_PROJECT_PATH             Path where the project is placed.
# @param[in]    MAVEN_DEPLOY_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_DEPLOY_ADDITIONAL_PARAMETERS    Additional parameters to pass to maven.
##
.PHONY: maven-deploy
maven-deploy:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-deploy

.PHONY: _maven-deploy
_maven-deploy:
	@echo "🚗 Deploying your maven application..."
	mvn $(MAVEN_DEPLOY_VERBOSITY) deploy $(MAVEN_DEPLOY_PROJECT_PATH) $(MAVEN_DEPLOY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed deploying your maven application!"

##
# @function     tar-docker-push
# @brief        Job pushing container image tar file into an image registry
# @param[in]    TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH    Location and full file name of the container image file
# @param[in]    TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME       Source image name and tag of the container image
# @param[in]    TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME  Destination image name and tag of the container image
##
.PHONY: tar-docker-push
tar-docker-push:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tar-docker-push

.PHONY: _tar-docker-push
_tar-docker-push:
	@echo "☁️ Pushing container image to $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)..."
	docker image load --input $(TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH)
	docker image tag $(TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME) $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	docker push $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	@echo "✅ Completed pushing image!"

##
# @function     tar-crane-push
# @brief        Job pushing container image tar file into an image registry using crane
# @param[in]    TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED        Enable seeding of remote authentication credentials
# @param[in]    TAR_CRANE_DOCKER_AUTH_CONFIG                Docker authentication configuration
# @param[in]    TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH         Location and full file name of the container image file
# @param[in]    TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME       Destination image name and tag of the container image
# @param[in]    TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS        Additional parameters for crane
##
.PHONY: tar-crane-push
tar-crane-push:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tar-crane-push

.PHONY: _tar-crane-push
_tar-crane-push:
	@if [ "$(TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED)" = "true" ] || [ "$(TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED)" = "True" ] || [ "$(TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED)" = "t" ] || [ "$(TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED)" = "T" ]; then \
		echo "🔑 Seeding remote authentication credentials..."; \
		DOCKER_CONFIG=/kaniko/.docker; \
		echo $(TAR_CRANE_DOCKER_AUTH_CONFIG) > /kaniko/.docker/config.json; \
		echo "✅ Completed seeding remote authentication credentials!"; \
	fi
	@echo "☁️ Pushing container image to $(TAR_KANIKO_PUSH_DESTINATION_IMAGE_NAME)..."
	crane push $(TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH) "$(TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME)" $(TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed pushing image!"
