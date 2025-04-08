# Include Directives
include pipeline.mk

# Variables
DOCKERFILE_PATH = ./Test/Dotnet/TestDotNetWebApp
CONTAINER_IMAGE_NAME = testdotnetwebapp
CONTAINER_IMAGE_TAG = edge
CONTAINER_BUILD_ADDITIONAL_PARAMETERS :=

# Dotnet Application Variables
DOTNET_SP_PATH = ./Test/Dotnet/TestDotNetWebApp/
DOTNET_SP_TEST_PATH =  ./Test/Dotnet/xUnitSample
DOTNET_SP_TEST_VERBOSITY = normal
DOTNET_SP_TEST_ADDITIONAL_FLAGS :=
DOTNET_SP_TEST_TOOL = xunit
DOTNET_SP_PUBLISH_OUTPUT_PATH = ./Test/Dotnet/TestDotNetWebApp/publish
DOTNET_SP_PUBLISH_VERBOSITY = normal
DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS :=
DOTNET_BUILD_SP_PATH = ./Test/Dotnet/
DOTNET_BUILD_VERBOSITY = normal
DOTNET_BUILD_ADDITIONAL_PARAMETERS :=

##
# @brief Build the application
#
# This target builds the whole app using the defined Docker image.
##

# Jobs
.PHONY: helloworld
helloworld:
	pwd
	git --version
	make --version

.PHONY: app-test
app-test: dotnet-test

.PHONY: build
build: docker-build

.PHONY: clean
clean: dotnet-clean
