##
# @file         default-startup.mk
# @brief        Default variable for startup jobs.
# @author       Bryan James
# @date         2025-06-12
#
# This mk file contains variable definition for startup jobs.
##

## go-init
GO_INIT_PATH = ./
GO_INIT_ADDITIONAL_PARAMETERS :=

## print-echo
ECHO_VAR = World

## relayspark-clone
RELAYSPARK_GIT_URL = https://github.com/BryanJames16/RelaySpark.git
RELAYSPARK_FOLDER_FILE = ./.relayspark

## terraform-init
TERRAFORM_INIT_ENABLE_CLEAN_FOLDER := False
TERRAFORM_INIT_ENABLE_TF_CREDS = False
TERRAFORM_INIT_TF_CREDS :=
TERRAFORM_INIT_ENABLE_TF_RC = False
TERRAFORM_INIT_TF_RC :=
TERRAFORM_INIT_BACKEND_CONFIG_FILE = ./development.conf
TERRAFORM_INIT_ADDITIONAL_PARAMETERS :=
TERRAFORM_INIT_ENABLE_WORKSPACE = False
TERRAFORM_INIT_TARGET_WORKSPACE :=

## tofu-init
TOFU_INIT_ENABLE_CLEAN_FOLDER := False
TOFU_INIT_ENABLE_TF_CREDS = False
TOFU_INIT_TF_CREDS :=
TOFU_INIT_ENABLE_TF_RC = False
TOFU_INIT_TF_RC :=
TOFU_INIT_BACKEND_CONFIG_FILE = ./development.conf
TOFU_INIT_ADDITIONAL_PARAMETERS :=
TOFU_INIT_ENABLE_WORKSPACE = False
TOFU_INIT_TARGET_WORKSPACE :=
