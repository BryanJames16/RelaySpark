# Dotnet Application Variables
DOTNET_SP_PATH = ./Test/Dotnet/TestDotNetWebApp/
DOTNET_SP_TEST_PATH =  ./Test/Dotnet/xUnitSample
DOTNET_SP_TEST_VERBOSITY = normal
DOTNET_SP_TEST_ADDITIONAL_FLAGS :=
DOTNET_SP_PUBLISH_OUTPUT_PATH = ./Test/Dotnet/TestDotNetWebApp/publish
DOTNET_SP_PUBLISH_VERBOSITY = normal
DOTNET_SP_PUBLISH_ADDITIONAL_FLAGS :=

# Include Directives
include Core/startup.mk
include Core/build.mk
include Core/test.mk
include Core/clean.mk
