##
# @file clean.mk
# @brief Contains all jobs for performing project clean up.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains common and reusable jobs for performing application clean up.
# Common clean up scripts and jobs are shared within this file.
##

##
# @function     dotnet-clean
# @brief        Job for cleaning .NET project or solution (.NET Core)
# @param[in]    DOTNET_CLEAN_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_CLEAN_VERBOSITY                Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    DOTNET_CLEAN_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet clean`.
##
.PHONY: dotnet-clean
dotnet-clean:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_CLEAN_SP_PATH) -v $(DOTNET_CLEAN_VERBOSITY) $(DOTNET_CLEAN_ADDITIONAL_PARAMETERS)
	@echo "Clean up done!"

##
# @function     maven-clean
# @brief        Job for cleaning Maven projects
# @param[in]    MAVEN_CLEAN_PROJECT_PATH                  Path where the project or the solution file is placed.
# @param[in]    MAVEN_CLEAN_VERBOSITY                Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`
# @param[in]    MAVEN_CLEAN_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet clean`.
##
.PHONY: maven-clean
maven-clean:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-clean

.PHONY: _maven-clean
_maven-clean:
	@echo "Performing maven clean..."
	mvn $(MAVEN_CLEAN_VERBOSITY) test $(MAVEN_CLEAN_PROJECT_PATH) $(MAVEN_CLEAN_ADDITIONAL_PARAMETERS)
	@echo "Completed maven clean!"
