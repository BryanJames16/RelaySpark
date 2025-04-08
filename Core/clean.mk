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
	make _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_CLEAN_SP_PATH) -v $(DOTNET_CLEAN_VERBOSITY) $(DOTNET_CLEAN_ADDITIONAL_PARAMETERS)
	@echo "Clean up done!"
