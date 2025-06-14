##
# @file         default-publish.mk
# @brief        Default variable for publish jobs.
# @author       Bryan James
# @date         2025-06-12
#
# This mk file contains variable definition for publish jobs.
##

## archive-publish
ARCHIVE_PUBLISH_ARCHIVE_TYPE = 7z
ARCHIVE_PUBLISH_SOURCE_DIR = ./
ARCHIVE_PUBLISH_OUTPUT_NAME = publish
ARCHIVE_PUBLISH_ZIP_ADDITIONAL_PARAMETERS :=
ARCHIVE_PUBLISH_TAR_ADDITIONAL_PARAMETERS :=
ARCHIVE_PUBLISH_XZ_ADDITIONAL_PARAMETERS :=
ARCHIVE_PUBLISH_7Z_ADDITIONAL_PARAMETERS :=
ARCHIVE_PUBLISH_UPX_ADDITIONAL_PARAMETERS :=

## cargo-package
CARGO_PUBLISH_MANIFEST_PATH = ./Cargo.toml
CARGO_PUBLISH_TYPE = package-only
CARGO_PACKAGE_ADDITIONAL_PARAMETERS :=
CARGO_PUBLISH_ADDITIONAL_PARAMETERS :=

## dotnet-publish
DOTNET_PUBLISH_SP_PATH = ./
DOTNET_PUBLISH_OUTPUT_PATH = ./publish
DOTNET_PUBLISH_VERBOSITY = n
DOTNET_PUBLISH_ADDITIONAL_PARAMETERS :=

## helm-package
HELM_CHART_PACKAGE_PATH = ./
HELM_CHART_PACKAGE_NAME = helm_app
HELM_CHART_PACKAGE_VERSION = v1.0.0
HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS :=
HELM_CHART_PACKAGE_SIGNING_ENABLED = false
HELM_CHART_PACKAGE_KEY = sample_key
HELM_CHART_PACKAGE_KEYRING = ~/.gnupg/pubring.kbx

## helm-push
HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED = false
HELM_CHART_PUSH_REG_AUTH_CONFIG :=
HELM_CHART_PUSH_PATH = ./helm_app-v1.0.0.tgz
HELM_CHART_PUSH_REMOTE_URL = https://artifacthub.io/

## maven-deploy
MAVEN_DEPLOY_PROJECT_PATH = ./
MAVEN_DEPLOY_VERBOSITY = --errors
MAVEN_DEPLOY_ADDITIONAL_PARAMETERS :=

## maven-package
MAVEN_PACKAGE_PROJECT_PATH = ./
MAVEN_PACKAGE_VERBOSITY = --errors
MAVEN_PACKAGE_ADDITIONAL_PARAMETERS :=

## npm-publish
NPM_PUBLISH_PACKAGE_SPEC = ./
NPM_PUBLISH_ADDITIONAL_PARAMETERS :=

## tar-docker-push
TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH = ./app_image.tar
TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME = app_image:v1.0.0
TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME = app_image:v1.0.0
TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED = false
TAR_DOCKER_PUSH_COSIGN_KEY_PATH = ./cosign.key
TAR_DOCKER_PUSH_COSIGN_ADDITIONAL_PARAMETERS :=

## tar-crane-push
TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED = false
TAR_CRANE_DOCKER_AUTH_CONFIG :=
TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH = ./app_image.tar
TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME = app_image:v1.0.0
TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS :=
TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED = false
TAR_CRANE_PUSH_COSIGN_KEY_PATH = ./cosign.key
TAR_CRANE_PUSH_SIGN_ADDITIONAL_PARAMETERS :=
