# Include Directives

include pipeline.mk

# Pipeline Jobs
.PHONY: app-test
app-test: dotnet-test

DOCKERFILE_PATH = ./Test/Dotnet/TestDotNetWebApp
CONTAINER_IMAGE_NAME = testdotnetwebapp
CONTAINER_IMAGE_TAG = edge
CONTAINER_BUILD_ADDITIONAL_PARAMETERS :=

.PHONY: build
build: docker-build

.PHONY: clean
clean: dotnet-clean
