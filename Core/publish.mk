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
	make _dotnet-publish

.PHONY: _dotnet-publish
_dotnet-publish:
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_PUBLISH_SP_PATH) --output $(DOTNET_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_PUBLISH_VERBOSITY) $(DOTNET_PUBLISH_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

##
# @function     docker-push
# @brief        Job pushing container image into an image registry
##
.PHONY: docker-push
docker-push:
	make _docker-push

.PHONY: _docker-push
_docker-push:
	@echo "Pushing container image to $(EXPORT_CONTAINER_IMAGE_NAME):$(EXPORT_CONTAINER_IMAGE_TAG)..."
	@echo "Completed pushing image!"
