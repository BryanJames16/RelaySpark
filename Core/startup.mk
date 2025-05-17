##
# @file startup.mk
# @brief Contains any start up and default jobs for pipelines.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains basic startup jobs and configuration for pipelines.
##

##
# @function     startup
# @brief        Start up banner for RelaySpark.
##
.PHONY: startup
startup:
	@echo  "  ___     _           ___                _    "
	@echo  " | _ \\___| |__ _ _  _/ __|_ __  __ _ _ _| |__ "
	@echo  " |   / -_) / _\` | || \\__ \\ '_ \\/ _\` | '_| / / "
	@echo  " |_|_\\___|_\\__,_|\\_, |___/ .__/\\__,_|_| |_\\_\\ "
	@echo  "                 |__/    |_|                  "

	make --version

##
# @function     print-echo
# @brief        Print a specific passed string.
# @param[in]    ECHO_VAR               Variable to echo.
##
.PHONY: print-echo
print-echo:
	@echo Hello $(ECHO_VAR)!

##
# @function     relayspark-clone
# @brief        Job for thin-cloning relayspark.
# @param[in]    RELAYSPARK_GIT_URL                    Git URL for RelaySpark.
# @param[in]    RELAYSPARK_FOLDER_FILE                Folders and file to clone.
##
.PHONY: relayspark-clone
relayspark-clone:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _relayspark-clone

.PHONY: _relayspark-clone
_relayspark-clone:
	@echo "⚡ Cloning RelaySpark repository..."
	mkdir -p .relayspark
	cd .relayspark
	git init
	git remote add origin $(RELAYSPARK_GIT_URL)
	git sparse-checkout init --no-cone
	git sparse-checkout set $(RELAYSPARK_FOLDER_FILE)
	git pull --depth=1 origin main
	@echo "✅ Done cloning RelaySpark repository!"

##
# @function     terraform-init
# @brief        Terraform initialization job.
# @param[in]    TERRAFORM_INIT_ENABLE_CLEAN_FOLDER         Flag for enabling clean up of .terraform and .tofu folders.
# @param[in]    TERRAFORM_INIT_ENABLE_TF_CREDS             Flag for enabling Terraform credentials.
# @param[in]    TERRAFORM_INIT_TF_CREDS                    Terraform credentials.
# @param[in]    TERRAFORM_INIT_ENABLE_TF_RC                Flag for enabling Terraform remote credentials.
# @param[in]    TERRAFORM_INIT_TF_RC                       Terraform remote credentials.
# @param[in]    TERRAFORM_INIT_BACKEND_CONFIG_FILE         Full path and file name of Terraform backend config file.
# @param[in]    TERRAFORM_INIT_ADDITIONAL_PARAMETERS       Terraform initialization additional parameters.
# @param[in]    TERRAFORM_INIT_ENABLE_WORKSPACE            Flag for enabling Terraform workspace.
# @param[in]    TERRAFORM_INIT_TARGET_WORKSPACE            Target workspace name for the job.
##
.PHONY: terraform-init
terraform-init:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _terraform-init

.PHONY: _terraform-init
_terraform-init:
	@echo "🔌 Performing Terraform initialization...."
	terraform version
	@if [ "$(TERRAFORM_INIT_ENABLE_CLEAN_FOLDER)" = "true" ] || [ "$(TERRAFORM_INIT_ENABLE_CLEAN_FOLDER)" = "True" ] || [ "$(TERRAFORM_INIT_ENABLE_CLEAN_FOLDER)" = "t" ] || [ "$(TERRAFORM_INIT_ENABLE_CLEAN_FOLDER)" = "T" ]; then \
		rm -rf .terraform || true; \
		rm -rf .tofu || true; \
	fi
	@if [ "$(TERRAFORM_INIT_ENABLE_TF_CREDS)" = "true" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_CREDS)" = "True" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_CREDS)" = "t" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_CREDS)" = "T" ]; then \
		echo $(TERRAFORM_INIT_TF_CREDS) > /root/.terraform.d/credentials.tfrc.json; \
	fi
	@if [ "$(TERRAFORM_INIT_ENABLE_TF_RC)" = "true" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_RC)" = "True" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_RC)" = "t" ] || [ "$(TERRAFORM_INIT_ENABLE_TF_RC)" = "T" ]; then \
		echo $(TERRAFORM_INIT_TF_RC) > /root/.teraformrc; \
	fi
	terraform init -backend-config=$(TERRAFORM_INIT_BACKEND_CONFIG_FILE) $(TERRAFORM_INIT_ADDITIONAL_PARAMETERS)
	@if [ "$(TERRAFORM_INIT_ENABLE_WORKSPACE)" = "true" ] || [ "$(TERRAFORM_INIT_ENABLE_WORKSPACE)" = "True" ] || [ "$(TERRAFORM_INIT_ENABLE_WORKSPACE)" = "t" ] || [ "$(TERRAFORM_INIT_ENABLE_WORKSPACE)" = "T" ]; then \
		terraform workspace select $(TERRAFORM_INIT_TARGET_WORKSPACE) || terraform workspace new $(TERRAFORM_INIT_TARGET_WORKSPACE); \
	fi
	@echo "✅ Done initializing Terraform!"

##
# @function     tofu-init
# @brief        OpenTofu initialization job.
# @param[in]    TOFU_INIT_ENABLE_CLEAN_FOLDER         Flag for enabling clean up of .terraform and .tofu folders.
# @param[in]    TOFU_INIT_ENABLE_TF_CREDS             Flag for enabling OpenTofu credentials.
# @param[in]    TOFU_INIT_TF_CREDS                    OpenTofu credentials.
# @param[in]    TOFU_INIT_ENABLE_TF_RC                Flag for enabling OpenTofu remote credentials.
# @param[in]    TOFU_INIT_TF_RC                       OpenTofu remote credentials.
# @param[in]    TOFU_INIT_BACKEND_CONFIG_FILE         Full path and file name of OpenTofu backend config file.
# @param[in]    TOFU_INIT_ADDITIONAL_PARAMETERS       OpenTofu initialization additional parameters.
# @param[in]    TOFU_INIT_ENABLE_WORKSPACE            Flag for enabling OpenTofu workspace.
# @param[in]    TOFU_INIT_TARGET_WORKSPACE            Target workspace name for the job.
##
.PHONY: tofu-init
tofu-init:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-init

.PHONY: _tofu-init
_tofu-init:
	@echo "🔌 Performing OpenTofu initialization...."
	tofu version
	@if [ "$(TOFU_INIT_ENABLE_CLEAN_FOLDER)" = "true" ] || [ "$(TOFU_INIT_ENABLE_CLEAN_FOLDER)" = "True" ] || [ "$(TOFU_INIT_ENABLE_CLEAN_FOLDER)" = "t" ] || [ "$(TOFU_INIT_ENABLE_CLEAN_FOLDER)" = "T" ]; then \
		rm -rf .terraform || true; \
		rm -rf .tofu || true; \
	fi
	@if [ "$(TOFU_INIT_ENABLE_TF_CREDS)" = "true" ] || [ "$(TOFU_INIT_ENABLE_TF_CREDS)" = "True" ] || [ "$(TOFU_INIT_ENABLE_TF_CREDS)" = "t" ] || [ "$(TOFU_INIT_ENABLE_TF_CREDS)" = "T" ]; then \
		echo $(TOFU_INIT_TF_CREDS) > /root/.terraform.d/credentials.tfrc.json; \
	fi
	@if [ "$(TOFU_INIT_ENABLE_TF_RC)" = "true" ] || [ "$(TOFU_INIT_ENABLE_TF_RC)" = "True" ] || [ "$(TOFU_INIT_ENABLE_TF_RC)" = "t" ] || [ "$(TOFU_INIT_ENABLE_TF_RC)" = "T" ]; then \
		echo $(TOFU_INIT_TF_RC) > /root/.teraformrc; \
	fi
	tofu init -backend-config=$(TOFU_INIT_BACKEND_CONFIG_FILE) $(TOFU_INIT_ADDITIONAL_PARAMETERS)
	@if [ "$(TOFU_INIT_ENABLE_WORKSPACE)" = "true" ] || [ "$(TOFU_INIT_ENABLE_WORKSPACE)" = "True" ] || [ "$(TOFU_INIT_ENABLE_WORKSPACE)" = "t" ] || [ "$(TOFU_INIT_ENABLE_WORKSPACE)" = "T" ]; then \
		tofu workspace select $(TOFU_INIT_TARGET_WORKSPACE) || tofu workspace new $(TOFU_INIT_TARGET_WORKSPACE); \
	fi
	@echo "✅ Done initializing OpenTofu!"
