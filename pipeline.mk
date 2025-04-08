##
# @file pipeline.mk
# @brief Inclusion of all pipeline jobs to one file.
# @author Bryan James
# @date 2025-04-08
#
# This mk file contains include annotations for all pipeline files.
# This is the file that should be included on your project's Makefile.
##

# Include Core Files
include Core/startup.mk
include Core/build.mk
include Core/publish.mk
include Core/test.mk
include Core/clean.mk
