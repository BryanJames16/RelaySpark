.PHONY: dotnet-clean
dotnet-clean: dotnet-publish
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_SP_PATH)
	@echo "Clean up done!"
