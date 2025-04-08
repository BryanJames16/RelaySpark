.PHONY: dotnet-clean
dotnet-clean:
	make _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "Performing clean up..."
	dotnet clean $(DOTNET_SP_PATH)
	@echo "Clean up done!"
