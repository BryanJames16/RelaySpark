.PHONY: dotnet-publish
dotnet-publish:
	make _dotnet-publish

.PHONY: _dotnet-publish
_dotnet-publish:
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_SP_PATH) --output $(DOTNET_SP_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_SP_PUBLISH_VERBOSITY) $(DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

.PHONY: docker-push
docker-push:
	make _docker-push

.PHONY: _docker-push
_docker-push:
	@echo "Pushing container image to $(EXPORT_CONTAINER_IMAGE_NAME):$(EXPORT_CONTAINER_IMAGE_TAG)..."
	@echo "Completed pushing image!"
