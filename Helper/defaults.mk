##
# @file         defaults.mk
# @brief        Default variable values.
# @author       Bryan James
# @date         2025-04-08
#
# This mk file contains variable definition for all jobs.
##

## ----------------------------------
#  General Configurations
## ----------------------------------
MAKE = make
CONTAINER_COMMAND_BASE = docker compose run
CONTAINER_COMMAND_PARAMETER = --rm
CONTAINER_COMMAND_SERVICE = alpine
RELAYSPARK_GIT_URL = https://github.com/BryanJames16/RelaySpark.git
RELAYSPARK_FOLDER_FILE = Core Helper pipeline.mk
ECHO_VAR = World

## ----------------------------------
#  BUILD
## ----------------------------------

## =====================
## .NET
## =====================

## dotnet-build
DOTNET_BUILD_SP_PATH = ./
DOTNET_BUILD_VERBOSITY = minimal
DOTNET_BUILD_ADDITIONAL_PARAMETERS :=

## =====================
## Java
## =====================

## maven-build
MAVEN_BUILD_PROJECT_PATH = ./
MAVEN_BUILD_VERBOSITY = --errors
MAVEN_BUILD_ADDITIONAL_PARAMETERS :=

## =====================
## NodeJS
## =====================

## npm-build
NPM_BUILD_DIRECTORY = ./
NPM_BUILD_ADDITIONAL_PARAMETERS :=

## =====================
## Docker
## =====================

## docker-build
CONTAINER_BUILD_IMAGE_NAME = app_image
CONTAINER_BUILD_IMAGE_TAG = v1.0.0
DOCKERFILE_PATH = ./
CONTAINER_BUILD_ADDITIONAL_PARAMETERS :=

## helm-build
HELM_CHART_BUILD_PATH = ./
HELM_CHART_BUILD_NAME = helm_app
HELM_CHART_BUILD_VERSION = v1.0.0
HELM_CHART_BUILD_ADDITIONAL_PARAMETERS :=

## kaniko-build
KANIKO_BUILD_IMAGE_NAME = app_image
KANIKO_BUILD_IMAGE_TAG = v1.0.0
KANIKO_DOCKER_AUTH_CONFIG_ENABLED = false
KANIKO_DOCKER_AUTH_CONFIG :=
KANIKO_DOCKERFILE_PATH = ./Dockerfile
KANIKO_BUILD_PROJECT_DIR = ./
KANIKO_BUILD_ADDITIONAL_PARAMETERS :=

## ----------------------------------
#  CLEAN
## ----------------------------------

## =====================
## .NET
## =====================

## dotnet-clean
DOTNET_CLEAN_SP_PATH = ./
DOTNET_CLEAN_VERBOSITY = minimal
DOTNET_CLEAN_ADDITIONAL_PARAMETERS :=

## =====================
## Java
## =====================

## maven-clean
MAVEN_CLEAN_PROJECT_PATH = ./
MAVEN_CLEAN_VERBOSITY = --errors
MAVEN_CLEAN_ADDITIONAL_PARAMETERS :=


## ----------------------------------
#  PUBLISH
## ----------------------------------

## =====================
## .NET
## =====================

## dotnet-publish
DOTNET_PUBLISH_SP_PATH =
DOTNET_PUBLISH_OUTPUT_PATH =
DOTNET_PUBLISH_VERBOSITY =
DOTNET_PUBLISH_ADDITIONAL_FLAGS :=

## =====================
## Java
## =====================

## maven-package
MAVEN_PACKAGE_PROJECT_PATH = ./
MAVEN_PACKAGE_VERBOSITY = --errors
MAVEN_PACKAGE_ADDITIONAL_PARAMETERS :=

## maven-deploy
MAVEN_DEPLOY_PROJECT_PATH = ./
MAVEN_DEPLOY_VERBOSITY = --errors
MAVEN_DEPLOY_ADDITIONAL_PARAMETERS :=

## =====================
## Docker
## =====================

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

## ----------------------------------
#  SECURITY
## ----------------------------------

## =====================
## Trivy
## =====================

## trivy-scan
TRIVY_SCAN_TYPE = sast

## trivy-image-scan
TRIVY_IMAGE_SCAN_IMAGE_URL = python:3.4-alpine
TRIVY_IMAGE_SCAN_OUTPUT_FORMAT = json
TRIVY_IMAGE_SCAN_OUTPUT_FILE = ./trivy-image-scan-report.json
TRIVY_IMAGE_SCAN_EXIT_CODE = 1
TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS :=

## trivy-fs-scan
TRIVY_FS_SCAN_PATH = ./
TRIVY_FS_SCAN_OUTPUT_FORMAT = json
TRIVY_FS_SCAN_OUTPUT_FILE = ./trivy-fs-scan-report.json
TRIVY_FS_SCAN_EXIT_CODE = 1
TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS :=

## trivy-repo-scan
TRIVY_REPO_SCAN_URL = ./
TRIVY_REPO_SCAN_OUTPUT_FORMAT = json
TRIVY_REPO_SCAN_OUTPUT_FILE = ./trivy-repo-scan-report.json
TRIVY_REPO_SCAN_EXIT_CODE = 1
TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS :=

## =====================
## GitLeaks
## =====================

## gitleaks-scan
GITLEAKS_SCAN_TYPE = file

## gitleaks-dir-scan
GITLEAKS_DIR_SCAN_PATH = ./
GITLEAKS_DIR_SCAN_OUTPUT_FORMAT = json
GITLEAKS_DIR_SCAN_OUTPUT_FILE = ./gitleaks-dir-scan-report.json
GITLEAKS_DIR_SCAN_EXIT_CODE = 1
GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS :=

## gitleaks-repo-scan
GITLEAKS_REPO_SCAN_PATH = ./
GITLEAKS_REPO_SCAN_OUTPUT_FORMAT = json
GITLEAKS_REPO_SCAN_OUTPUT_FILE = ./gitleaks-repo-scan-report.json
GITLEAKS_REPO_SCAN_EXIT_CODE = 1
GITLEAKS_REPO_SCAN_ADDITIONAL_PARAMETERS :=

## =====================
## Kubesec
## =====================

## kubesec-scan
KUBESEC_SCAN_TYPE = manifest

## kubesec-manifest-scan
KUBESEC_MANIFEST_SCAN_PATH = ./Test
KUBESEC_MANIFEST_SCAN_ADDITIONAL_PARAMETERS :=

## kubesec-helm-scan
KUBESEC_HELM_VALUES_SCAN_PATH = values.yaml
KUBESEC_HELM_SCAN_PATH = ./
KUBESEC_HELM_SCAN_ADDITIONAL_PARAMETERS :=

## =====================
## Cosign
## =====================

## cosign-container-image-tar-signing
COSIGN_CONTAINER_SIGNING_KEY_PATH = ./cosign.key
COSIGN_CONTAINER_IMAGE_PATH = ./app_image.tar
COSIGN_CONTAINER_IMAGE_ADDITIONAL_PARAMETERS :=

## cosign-blob-signing
COSIGN_BLOB_SIGNING_KEY_PATH = ./cosign.key
COSIGN_BLOB_FILE = ./README.md
COSIGN_BLOB_ADDITIONAL_PARAMETERS :=

##

## ----------------------------------
#  TEST
## ----------------------------------

## =====================
## .NET
## =====================

## dotnet-test
DOTNET_TEST_TOOL = xunit
DOTNET_TEST_SP_PATH = ./
DOTNET_TEST_VERBOSITY = --normal
DOTNET_TEST_ADDITIONAL_FLAGS :=

## =====================
## Java
## =====================

## maven-validate
MAVEN_VALIDATE_PROJECT_PATH = ./
MAVEN_VALIDATE_VERBOSITY = --errors
MAVEN_VALIDATE_ADDITIONAL_PARAMETERS :=

## maven-test
MAVEN_TEST_PROJECT_PATH = ./
MAVEN_TEST_VERBOSITY = --errors
MAVEN_TEST_ADDITIONAL_PARAMETERS :=

## =====================
## Docker
## =====================

## helm-lint
HELM_CHART_PACKAGE_LINT_PATH = ./
HELM_CHART_PACKAGE_LINT_NAME = helm_app
HELM_CHART_PACKAGE_LINT_ADDITIONAL_PARAMETERS :=

## helm-template
HELM_CHART_PACKAGE_TEMPLATE_PATH = ./
HELM_CHART_PACKAGE_TEMPLATE_NAME = helm_app
HELM_CHART_PACKAGE_TEMPLATE_ADDITIONAL_PARAMETERS :=

## helm-test
HELM_CHART_TEST_PATH = ./
HELM_CHART_TEST_NAME = helm_app
HELM_CHART_TEST_NAMESPACE = default
HELM_CHART_TEST_ADDITIONAL_PARAMETERS :=

## =====================
## Accessibility
## =====================

## pa11y
PA11Y_CI_CONFIG = ./
PA11Y_CI_SITEMAP = https://127.0.0.1/sitemap
PA11Y_CI_ADDITIONAL_CONFIG :=

## axe-scan
AXE_SCAN_RESULTS_CSV = ./results.csv
AXE_SCAN_ADDITIONAL_PARAMTERS :=
AXE_SCAN_SUMMARY_ENABLED = false
AXE_SCAN_SUMMARY_ADDITIONAL_PARAMTERS :=
