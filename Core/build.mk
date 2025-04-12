##
# @file         build.mk
# @brief        Build jobs for all kinds of applications.
# @author       Bryan James
# @date         2025-04-08
#
# This mk file contains job for building applications.
##

##
# @function     dotnet-build
# @brief        Job for building .NET application (.NET Core)
# @param[in]    DOTNET_BUILD_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_BUILD_VERBOSITY                Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    DOTNET_BUILD_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet build`.
##
.PHONY: dotnet-build
dotnet-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-build

.PHONY: _dotnet-build
_dotnet-build:
	@echo "Performing dotnet build..."
	dotnet build $(DOTNET_BUILD_SP_PATH) -v $(DOTNET_BUILD_VERBOSITY) $(DOTNET_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed dotnet build!"

##
# @function     maven-compile
# @brief        Job for building Maven-based application
# @param[in]    MAVEN_BUILD_PROJECT_PATH             Path where the project is located.
# @param[in]    MAVEN_BUILD_VERBOSITY                Verbosity of the build. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_BUILD_ADDITIONAL_PARAMETERS    Additional parameters to pass to maven.
##
.PHONY: maven-compile
maven-compile:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-compile

.PHONY: _maven-compile
_maven-compile:
	@echo "Performing maven compile..."
	mvn $(MAVEN_BUILD_VERBOSITY) compile $(MAVEN_BUILD_PROJECT_PATH) $(MAVEN_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed maven compile!"

##
# @function     docker-build
# @brief        Job for building container images using Docker
# @param[in]    CONTAINER_BUILD_IMAGE_NAME               The full container image name.
# @param[in]    CONTAINER_BUILD_IMAGE_TAG                Tag of the container image to use.
# @param[in]    DOCKERFILE_PATH                          Path of the Dockerfile.
# @param[in]    CONTAINER_BUILD_ADDITIONAL_PARAMETERS    Additional docker build parameters
##
.PHONY: docker-build
docker-build:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _docker-build

.PHONY: _docker-build
_docker-build:
	@echo "Performing docker build..."
	docker build -t $(CONTAINER_BUILD_IMAGE_NAME):$(CONTAINER_BUILD_IMAGE_TAG) $(DOCKERFILE_PATH) $(CONTAINER_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed docker build!"
