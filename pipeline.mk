##
# @file pipeline.mk
# @brief Inclusion of all pipeline jobs to one file.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains include annotations for all pipeline files.
# This is the file that should be included on your project's Makefile.
##

PIPELINE_MK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Include Core Files
include $(PIPELINE_MK_DIR)Core/startup.mk
include $(PIPELINE_MK_DIR)Core/build.mk
include $(PIPELINE_MK_DIR)Core/publish.mk
include $(PIPELINE_MK_DIR)Core/test.mk
include $(PIPELINE_MK_DIR)Core/clean.mk
include $(PIPELINE_MK_DIR)Core/security.mk

# Include Helper Files
include $(PIPELINE_MK_DIR)Helper/Defaults/default-build.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-clean.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-general.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-publish.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-security.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-startup.mk
include $(PIPELINE_MK_DIR)Helper/Defaults/default-test.mk
