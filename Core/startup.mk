##
# @file startup.mk
# @brief Contains any start up and default jobs for pipelines.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains basic startup jobs and configuration for pipelines.
# There's really no important jobs within startup.mk aside from hello world and banner.
##

##
# @function     startup
# @brief        Startup banner for RelaySpark
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
# @brief        Print a specific passed string
# @param[in]    ECHO_VAR               Variable to echo
##
.PHONY: print-echo
print-echo:
	@echo Hello $(ECHO_VAR)!
