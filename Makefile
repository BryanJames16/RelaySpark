# Dotnet Application Variables
DOTNET_SP_PATH = ./Test/Dotnet/TestDotNetWebApp/TestDotNetWebApp.csproj
DOTNET_SP_TEST_PATH = 
DOTNET_SP_OUTPUT_PATH = ./Test/Dotnet/TestDotNetWebApp/publish
DOTNET_SP_VERBOSITY = normal
DOTNET_SP_ADDITIONAL_FLAGS :=

# Test Jobs
dotnet-test:
	@echo "Performing unit testing..."
	dotnet
	@echo "Unit test completed!"

# Build Jobs
dotnet-publish:
	@echo "Building and publishing dotnet application..."
	dotnet publish $(DOTNET_SP_PATH) --output $(DOTNET_SP_OUTPUT_PATH) --verbosity $(DOTNET_SP_VERBOSITY) $(DOTNET_SP_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

