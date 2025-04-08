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
# @namespace clean
# All cleaning jobs for projects, solutions, and code.
##

##
# @brief Clean the application repository.
#
# This target invokes the `_dotnet-clean` target to perform the cleanup.
#
# @fn dotnet-clean
# @param[in] DOTNET_SP_PATH  The path where the solution or project file can be found.
.PHONY: dotnet-clean
dotnet-clean:
	make _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_SP_PATH)
	@echo "Clean up done!"
