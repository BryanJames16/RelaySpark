##
# @brief Clean Application Repo
# @author Bryan James
#
# This target builds the whole app using the defined Docker image.
##

.PHONY: dotnet-clean
dotnet-clean:
	make _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_SP_PATH)
	@echo "Clean up done!"
