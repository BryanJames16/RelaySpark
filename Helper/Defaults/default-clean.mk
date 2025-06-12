##
# @file         default-clean.mk
# @brief        Default variable for clean jobs.
# @author       Bryan James
# @date         2025-06-12
#
# This mk file contains variable definition for clean jobs.
##

## dotnet-clean
DOTNET_CLEAN_SP_PATH = ./
DOTNET_CLEAN_VERBOSITY = minimal
DOTNET_CLEAN_ADDITIONAL_PARAMETERS :=

## maven-clean
MAVEN_CLEAN_PROJECT_PATH = ./
MAVEN_CLEAN_VERBOSITY = --errors
MAVEN_CLEAN_ADDITIONAL_PARAMETERS :=

## npm-clean
NPM_CLEAN_DIRECTORY = .

## terraform-destroy
TERRAFORM_DESTROY_ADDITIONAL_PARAMETERS :=

## tofu-destroy
TOFU_DESTROYY_ADDITIONAL_PARAMETERS :=
