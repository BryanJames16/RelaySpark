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
CONTAINER_BUILD_IMAGE_NAME = alpine
CONTAINER_BUILD_IMAGE_TAG = 3.211
DOCKERFILE_PATH = ./
CONTAINER_BUILD_ADDITIONAL_PARAMETERS :=


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
TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME = app_image:v1.0
TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME = app_image:v1.0


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
