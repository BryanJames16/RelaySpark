##
# @file         default-general.mk
# @brief        Default variable for generic jobs.
# @author       Bryan James
# @date         2025-06-12
#
# This mk file contains variable definition for generic jobs.
##

MAKE = make
CONTAINER_COMMAND_BASE = docker compose run
CONTAINER_COMMAND_PARAMETER = --rm
CONTAINER_COMMAND_SERVICE = alpine
