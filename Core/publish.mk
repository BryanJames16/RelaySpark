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
# @function     archive-publish
# @brief        Job for publishing generic packages into an archive.
# @param[in]    ARCHIVE_PUBLISH_ARCHIVE_TYPE         Type of the archive to be created. Possible values are `tar`, `zip`, `7z`, `xz`, and `upx`. Default is `7z`.
# @param[in]    ARCHIVE_PUBLISH_SOURCE_DIR           Directory containing contents of archival.
# @param[in]    ARCHIVE_PUBLISH_OUTPUT_NAME          Output name of the archive.
# @param[in]    ARCHIVE_PUBLISH_ZIP_ADDITIONAL_PARAMETERS          Additional parameters for command `zip`.
# @param[in]    ARCHIVE_PUBLISH_TAR_ADDITIONAL_PARAMETERS          Additional parameters for command `tar`.
# @param[in]    ARCHIVE_PUBLISH_XZ_ADDITIONAL_PARAMETERS           Additional parameters for command `xz`.
# @param[in]    ARCHIVE_PUBLISH_7Z_ADDITIONAL_PARAMETERS           Additional parameters for command `7z`.
# @param[in]    ARCHIVE_PUBLISH_UPX_ADDITIONAL_PARAMETERS          Additional parameters for command `upx`.
##
.PHONY: archive-publish
archive-publish:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _archive-publish

.PHONY: _archive-publish
_archive-publish:
	@echo "📜 Publishing into an archive..."
	ifeq ($(ARCHIVE_PUBLISH_ARCHIVE_TYPE),zip)
		echo "📦 Packaging as ZIP..."
		zip -r $(ARCHIVE_PUBLISH_OUTPUT_NAME).zip $(ARCHIVE_PUBLISH_SOURCE_DIR) $(ARCHIVE_PUBLISH_ZIP_ADDITIONAL_PARAMETERS)
	else ifeq ($(ARCHIVE_PUBLISH_ARCHIVE_TYPE),tar)
		echo "📦 Packaging as TAR..."
		tar -cvf $(ARCHIVE_PUBLISH_OUTPUT_NAME).tar $(ARCHIVE_PUBLISH_SOURCE_DIR) $(ARCHIVE_PUBLISH_TAR_ADDITIONAL_PARAMETERS)
	else ifeq ($(ARCHIVE_PUBLISH_ARCHIVE_TYPE),xz)
		echo "📦 Packaging as TAR.XZ..."
		tar -cf - $(ARCHIVE_PUBLISH_SOURCE_DIR) | xz -c > $(ARCHIVE_PUBLISH_OUTPUT_NAME).tar.xz $(ARCHIVE_PUBLISH_XZ_ADDITIONAL_PARAMETERS)
	else ifeq ($(ARCHIVE_PUBLISH_ARCHIVE_TYPE),7z)
		echo "📦 Creating 7z archive..."
		7z a $(ARCHIVE_PUBLISH_OUTPUT_NAME).7z $(ARCHIVE_PUBLISH_SOURCE_DIR) $(ARCHIVE_PUBLISH_7Z_ADDITIONAL_PARAMETERS)
	else ifeq ($(ARCHIVE_PUBLISH_ARCHIVE_TYPE),upx)
		echo "📦 Applying UPX compression..."
		upx -o $(ARCHIVE_PUBLISH_OUTPUT_NAME) $(ARCHIVE_PUBLISH_SOURCE_DIR) $(ARCHIVE_PUBLISH_UPX_ADDITIONAL_PARAMETERS)
		echo "UPX compression complete."
	else
		echo "Invalid archive type: $(ARCHIVE_PUBLISH_ARCHIVE_TYPE)"
		echo "Supported types: 7z, zip, tar, xz, upx"
		exit 1
	endif
	@echo "✅ Completed archive publishing!"

##
# @function     cargo-publish
# @brief        Package a rust application into a distributable crate.
# @param[in]    CARGO_PUBLISH_MANIFEST_PATH                Path where Cargo.toml is located.
# @param[in]    CARGO_PUBLISH_TYPE                         Actions of publishing to do. Valid values are `package-only` or `package-and-publish`. Default is `package-only`.
# @param[in]    CARGO_PACKAGE_ADDITIONAL_PARAMETERS        Additional build parameters for cargo package.
# @param[in]    CARGO_PUBLISH_ADDITIONAL_PARAMETERS        Additional build parameters for cargo publish.
##
.PHONY: cargo-package
cargo-package:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cargo-package

.PHONY: _cargo-package
_cargo-package:
	@echo "🔨 Performing cargo package..."
	cargo package --manifest-path $(CARGO_PUBLISH_MANIFEST_PATH) $(CARGO_PACKAGE_ADDITIONAL_PARAMETERS)
	@if [ "$(CARGO_PUBLISH_TYPE)" = "package-and-publish" ]; then \
		echo "📰 Publishing cargo package..."; \
		cargo publish --manifest-path $(CARGO_PUBLISH_MANIFEST_PATH) $(CARGO_PUBLISH_ADDITIONAL_PARAMETERS); \
		echo "✅ Completed publishing cargo package!"; \
	fi
	@echo "✅ Completed cargo package!"

##
# @function     dotnet-publish
# @brief        Job for publishing .NET project or solution (.NET Core).
# @param[in]    DOTNET_PUBLISH_SP_PATH               Path where the project or the solution file is placed.
# @param[in]    DOTNET_PUBLISH_OUTPUT_PATH           Output directory where the binaries will be stored.
# @param[in]    DOTNET_PUBLISH_VERBOSITY             Verbosity of the command output. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
# @param[in]    DOTNET_PUBLISH_ADDITIONAL_PARAMETERS Additional parameters to pass to `dotnet publish`.
##
.PHONY: dotnet-publish
dotnet-publish:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-publish

.PHONY: _dotnet-publish
_dotnet-publish:
	@echo "📜 Building and publishing dotnet application..."
	dotnet publish $(DOTNET_PUBLISH_SP_PATH) --output $(DOTNET_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_PUBLISH_VERBOSITY) $(DOTNET_PUBLISH_ADDITIONAL_PARAMETERS)
	@echo "✅ Build and publish done!"

##
# @function     helm-package
# @brief        Job for packaging Helm charts.
# @param[in]    HELM_CHART_PACKAGE_PATH                 Path where the helm chart is located.
# @param[in]    HELM_CHART_PACKAGE_NAME                 The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
# @param[in]    HELM_CHART_PACKAGE_VERSION              Version of the helm chart.
# @param[in]    HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS    Additional parameters to pass to command.
# @param[in]    HELM_CHART_PACKAGE_SIGNING_ENABLED      Flag for enabling helm chart signing.
# @param[in]    HELM_CHART_PACKAGE_KEY                  Signing key.
# @param[in]    HELM_CHART_PACKAGE_KEYRING              Signing keyring.
##
.PHONY: helm-package
helm-package:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-package

.PHONY: _helm-package
_helm-package:
	@echo "🔨 Performing helm package..."
	sed -i "s/helm_chart_name/$(HELM_CHART_PACKAGE_NAME)/" Chart.yaml
	@if [ "$(HELM_CHART_PACKAGE_SIGNING_ENABLED)" = "true" ] || [ "$(HELM_CHART_PACKAGE_SIGNING_ENABLED)" = "True" ] || [ "$(HELM_CHART_PACKAGE_SIGNING_ENABLED)" = "t" ] || [ "$(HELM_CHART_PACKAGE_SIGNING_ENABLED)" = "T" ]; then \
		helm package $(HELM_CHART_PACKAGE_PATH) --version $(HELM_CHART_PACKAGE_VERSION) --key $(HELM_CHART_PACKAGE_KEY) --keyring $(HELM_CHART_PACKAGE_KEYRING) --destination ./ $(HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS); \
	else
		helm package $(HELM_CHART_PACKAGE_PATH) --version $(HELM_CHART_PACKAGE_VERSION) $(HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS); \
	fi

	@echo "✅ Completed helm package!"
	@echo "🔨 Performing post-packaging verification..."
	helm inspect chart $(HELM_CHART_PACKAGE_PATH)-*.tgz
	@echo "✅ Completed post-packaging verification!"

##
# @function     helm-push
# @brief        Job for pushing Helm charts to repository.
# @param[in]    HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED  Flag for enabling authentication to chart registry.
# @param[in]    HELM_CHART_PUSH_REG_AUTH_CONFIG          Configuration for authentication to chart registry.
# @param[in]    HELM_CHART_PUSH_PATH                     Path where the helm chart is located.
# @param[in]    HELM_CHART_PUSH_REMOTE_URL               URL where the helm chart will be pushed.
# @param[in]    HELM_CHART_PUSH_ADDITIONAL_PARAMETERS    Additional parameters to pass to the command.
##
.PHONY: helm-push
helm-push:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _helm-push

.PHONY: _helm-push
_helm-push:
	@if [ "$(HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED)" = "true" ] || [ "$(HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED)" = "True" ] || [ "$(HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED)" = "t" ] || [ "$(HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED)" = "T" ]; then \
		echo "🔑 Seeding remote authentication credentials..."; \
		echo $(HELM_CHART_PUSH_REG_AUTH_CONFIG) > ~/.config/helm/registry/config.json; \
		echo "✅ Completed seeding remote authentication credentials!"; \
	fi
	@echo "☁️ Pushing helm chart to $(HELM_CHART_PUSH_REMOTE_URL)..."
	helm push $(HELM_CHART_PUSH_PATH) $(HELM_CHART_PUSH_REMOTE_URL) $(HELM_CHART_PUSH_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed pushing helm chart!"

##
# @function     maven-package
# @brief        Job for packaging maven projects.
# @param[in]    MAVEN_PACKAGE_PROJECT_PATH             Path where the project is placed.
# @param[in]    MAVEN_PACKAGE_VERBOSITY                Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
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
# @brief        Job for deploying maven projects.
# @param[in]    MAVEN_DEPLOY_PROJECT_PATH             Path where the project is placed.
# @param[in]    MAVEN_DEPLOY_VERBOSITY                Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
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
# @function     npm-publish
# @brief        Publish NPM packages to repository.
# @param[in]    NPM_PUBLISH_PACKAGE_SPEC             Path where the package is located.
# @param[in]    NPM_PUBLISH_ADDITIONAL_PARAMETERS    Additional parameters to pass to npm.
##
.PHONY: npm-publish
npm-publish:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-publish

.PHONY: _npm-publish
_npm-publish:
	@echo "🚗 Deploying your npm package..."
	npm publish $(NPM_PUBLISH_PACKAGE_SPEC) $(NPM_PUBLISH_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed deploying your npm package!"

##
# @function     tar-docker-push
# @brief        Job pushing container image tar file into an image registry.
# @param[in]    TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH    Location and full file name of the container image file.
# @param[in]    TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME       Source image name and tag of the container image.
# @param[in]    TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME  Destination image name and tag of the container image.
# @param[in]    TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED       Flag for enabling container signing.
# @param[in]    TAR_DOCKER_PUSH_COSIGN_KEY_PATH         Path of the Cosign key to use for image signing.
# @param[in]    TAR_DOCKER_PUSH_COSIGN_ADDITIONAL_PARAMETERS    Additional parameters for cosign container scanning.
##
.PHONY: tar-docker-push
tar-docker-push:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tar-docker-push

.PHONY: _tar-docker-push
_tar-docker-push:
	@echo "☁️ Pushing container image to $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)..."
	docker image load --input $(TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH)
	docker image tag $(TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME) $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	@if [ "$(TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED)" = "true" ] || [ "$(TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED)" = "True" ] || [ "$(TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED)" = "t" ] || [ "$(TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED)" = "T" ]; then \
		cosign sign --key $(TAR_DOCKER_PUSH_COSIGN_KEY_PATH) $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME);
	fi
	docker push $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	@echo "✅ Completed pushing image!"

##
# @function     tar-crane-push
# @brief        Job pushing container image tar file into an image registry using crane.
# @param[in]    TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED        Enable seeding of remote authentication credentials.
# @param[in]    TAR_CRANE_DOCKER_AUTH_CONFIG                Docker authentication configuration.
# @param[in]    TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH         Location and full file name of the container image file.
# @param[in]    TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME       Destination image name and tag of the container image.
# @param[in]    TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS        Additional parameters for crane.
# @param[in]    TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED    Flag for enabling container signing.
# @param[in]    TAR_CRANE_PUSH_COSIGN_KEY_PATH              Path where Cosign key can be found.
# @param[in]    TAR_CRANE_PUSH_SIGN_ADDITIONAL_PARAMETERS   Additional Parameters for Cosign.
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
	crane load -t $(TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH) $(TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH)
	@if [ "$(TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED)" = "true" ] || [ "$(TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED)" = "True" ] || [ "$(TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED)" = "t" ] || [ "$(TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED)" = "T" ]; then \
		cosign sign --key $(TAR_CRANE_PUSH_COSIGN_KEY_PATH) $(TAR_CRANE_PUSH_SIGN_ADDITIONAL_PARAMETERS) $(TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME); \
	fi
	crane push "$(TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME)" $(TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed pushing image!"
