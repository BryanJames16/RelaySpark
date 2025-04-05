# Dotnet Application Variables
DOTNET_SP_PATH = ./Test/Dotnet/TestDotNetWebApp/
DOTNET_SP_TEST_PATH =  ./Test/Dotnet/xUnitSample
DOTNET_SP_TEST_VERBOSITY = normal
DOTNET_SP_TEST_ADDITIONAL_FLAGS :=
DOTNET_SP_PUBLISH_OUTPUT_PATH = ./Test/Dotnet/TestDotNetWebApp/publish
DOTNET_SP_PUBLISH_VERBOSITY = normal
DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS :=

# Test Jobs
dotnet-test:
	@echo "Performing unit testing..."
	dotnet test $(DOTNET_SP_TEST_PATH) -v $(DOTNET_SP_TEST_VERBOSITY) $(DOTNET_SP_TEST_ADDITIONAL_FLAGS)
	@echo "Unit test completed!"

# Build Jobs
dotnet-publish: dotnet-test
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_SP_PATH) --output $(DOTNET_SP_PUBLISH_OUTPUT_PATH) --verbosity $(DOTNET_SP_PUBLISH_VERBOSITY) $(DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

# Cleaning Jobs
dotnet-clean: dotnet-publish
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_SP_PATH)
	@echo "Clean up done!"
