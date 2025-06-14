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
# @brief        Job for cleaning .NET project or solution (.NET Core).
# @param[in]    DOTNET_CLEAN_SP_PATH                  Path where the project or the solution file is placed.
# @param[in]    DOTNET_CLEAN_VERBOSITY                Verbosity of the command output. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
# @param[in]    DOTNET_CLEAN_ADDITIONAL_PARAMETERS    Additional parameters to pass to `dotnet clean`.
##
.PHONY: dotnet-clean
dotnet-clean:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _dotnet-clean

.PHONY: _dotnet-clean
_dotnet-clean:
	@echo "🧹 Performing clean up..."
	dotnet clean $(DOTNET_CLEAN_SP_PATH) -v $(DOTNET_CLEAN_VERBOSITY) $(DOTNET_CLEAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Clean up done!"

##
# @function     maven-clean
# @brief        Job for cleaning Maven projects.
# @param[in]    MAVEN_CLEAN_PROJECT_PATH             Path where the project is placed.
# @param[in]    MAVEN_CLEAN_VERBOSITY                Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
# @param[in]    MAVEN_CLEAN_ADDITIONAL_PARAMETERS    Additional parameters to pass to maven.
##
.PHONY: maven-clean
maven-clean:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _maven-clean

.PHONY: _maven-clean
_maven-clean:
	@echo "🧹 Performing maven clean..."
	mvn $(MAVEN_CLEAN_VERBOSITY) clean $(MAVEN_CLEAN_PROJECT_PATH) $(MAVEN_CLEAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed maven clean!"

##
# @function     npm-clean
# @brief        Clean NPM repository.
# @param[in]    NPM_CLEAN_DIRECTORY                  Path where the node project is located.
##
.PHONY: npm-clean
npm-clean:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _npm-clean

.PHONY: _npm-clean
_npm-clean:
	@echo "🧹 Performing clean up of NPM directory..."
	rm -rf $(NPM_CLEAN_DIRECTORY)/node-modules/
	@echo "✅ Completed clean up of NPM directory!"

##
# @function     terraform-destroy
# @brief        Job for performing terraform destroy.
# @param[in]    TERRAFORM_DESTROY_ADDITIONAL_PARAMETERS  Additional parameters to pass to terraform.
##
.PHONY: terraform-destroy
terraform-destroy:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _terraform-destroy

.PHONY: _terraform-destroy
_terraform-destroy:
	@echo "🧹 Performing terraform destroy..."
	terraform destroy -auto-approve $(TERRAFORM_DESTROY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed terraform destroy!"

##
# @function     tofu-destroy
# @brief        Job for performing tofu destroy.
# @param[in]    TOFU_DESTROY_ADDITIONAL_PARAMETERS  Additional parameters to pass to OpenTofu.
##
.PHONY: tofu-destroy
tofu-destroy:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-destroy

.PHONY: _tofu-destroy
_tofu-destroy:
	@echo "🧹 Performing tofu destroy..."
	tofu destroy -auto-approve $(TOFU_DESTROY_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed tofu destroy!"
