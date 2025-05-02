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
# @function     tofu-init
# @brief        OpenTofu initialization job.
# @param[in]    TOFU_INIT_ADDITIONAL_PARAMETERS       OpenTofu initialization additional parameters.
# @param[in]    RELAYSPARK_FOLDER_FILE                Folders and file to clone.
##
.PHONY: tofu-init
relayspark-clone:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _tofu-init

.PHONY: _tofu-init
_tofu-init:
	@echo "🔌 Performing OpenTofu initialization...."
	tofu version
	tofu init $(TOFU_INIT_ADDITIONAL_PARAMETERS)
	@echo "✅ Done initializint OpenTofu!"
