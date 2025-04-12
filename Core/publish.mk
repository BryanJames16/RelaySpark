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
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_PUBLISH_SP_PATH) --output $(DOTNET_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_PUBLISH_VERBOSITY) $(DOTNET_PUBLISH_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

##
# @function     docker-load-push
# @brief        Job pushing container image tar file into an image registry
# @param[in]    TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH    Location and full file name of the container image file
# @param[in]    TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME       Source image name and tag of the container image
# @param[in]    TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME  Destination image name and tag of the container image
##
.PHONY: tar-docker-push
docker-push:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _docker-push

.PHONY: _docker-push
_docker-push:
	@echo "Pushing container image to $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)..."
	docker image load --input $(TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH)
	docker image tag $(TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME) $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	docker push $(TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME)
	@echo "Completed pushing image!"
