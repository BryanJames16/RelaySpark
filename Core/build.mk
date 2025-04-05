.PHONY: dotnet-publish
dotnet-publish: dotnet-test
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_SP_PATH) --output $(DOTNET_SP_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_SP_PUBLISH_VERBOSITY) $(DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"
