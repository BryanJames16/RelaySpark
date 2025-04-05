# Dotnet Application Variables
PUBLISH_DOTNET_PATH = ./Test/Dotnet/TestDotNetWebApp/TestDotNetWebApp.csproj
PUBLISH_DOTNET_OUTPUT_PATH = ./Test/Dotnet/TestDotNetWebApp/publish
PUBLISH_DOTNET_VERBOSITY = normal
PUBLISH_DOTNET_ADDITIONAL_FLAGS := 

# Build Jobs
dotnet-publish:
	@echo "Building and publishing dotnet application..."
	dotnet publish $(PUBLISH_DOTNET_PATH) --output $(PUBLISH_DOTNET_OUTPUT_PATH) --verbosity $(PUBLISH_DOTNET_VERBOSITY) $(PUBLISH_DOTNET_ADDITIONAL_FLAGS)
	@echo "Build and publish done!"

