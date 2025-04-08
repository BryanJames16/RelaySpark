##
# @file build.mk
# @brief Build jobs for all kinds of applications.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains job for building applications.
##

.PHONY: dotnet-build
dotnet-build:
	make _dotnet-build

.PHONY: _dotnet-build
_dotnet-build:
	@echo "Performing dotnet build..."
	dotnet build $(DOTNET_BUILD_SP_PATH) -v $(DOTNET_BUILD_VERBOSITY) $(DOTNET_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed dotbet build!"

.PHONY: docker-build
docker-build:
	make _docker-build

.PHONY: _docker-build
_docker-build:
	@echo "Performing docker build..."
	docker build -t $(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG) $(DOCKERFILE_PATH) $(CONTAINER_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed docker build!"
