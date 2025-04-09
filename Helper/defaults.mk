## ----------------------------------
#  General Configurations
## ----------------------------------
MAKE = make

## ----------------------------------
#  SECURITY
## ----------------------------------

## =====================
## Trivy
## =====================

## trivy-scan
TRIVY_SCAN_TYPE = sast

## trivy-image-scan
TRIVY_IMAGE_SCAN_IMAGE_URL = python:3.4-alpine
TRIVY_IMAGE_SCAN_OUTPUT_FORMAT = json
TRIVY_IMAGE_SCAN_OUTPUT_FILE = ./trivy-image-scan-report.json
TRIVY_IMAGE_SCAN_EXIT_CODE = 1
TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS :=

## trivy-fs-scan
TRIVY_FS_SCAN_PATH = ./
TRIVY_FS_SCAN_OUTPUT_FORMAT = json
TRIVY_FS_SCAN_OUTPUT_FILE = ./trivy-fs-scan-report.json
TRIVY_FS_SCAN_EXIT_CODE = 1
TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS :=

## trivy-repo-scan
TRIVY_REPO_SCAN_URL = ./
TRIVY_REPO_SCAN_OUTPUT_FORMAT = json
TRIVY_REPO_SCAN_OUTPUT_FILE = ./trivy-repo-scan-report.json
TRIVY_REPO_SCAN_EXIT_CODE = 1
TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS :=

## =====================
## GitLeaks
## =====================

## gitleaks-scan
GITLEAKS_SCAN_TYPE = file

## gitleaks-dir-scan
GITLEAKS_DIR_SCAN_PATH = ./
GITLEAKS_DIR_SCAN_OUTPUT_FORMAT = json
GITLEAKS_DIR_SCAN_OUTPUT_FILE = ./gitleaks-dir-scan-report.json
GITLEAKS_DIR_SCAN_EXIT_CODE = 1
GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS :=

## gitleaks-repo-scan
GITLEAKS_REPO_SCAN_PATH = ./
GITLEAKS_REPO_SCAN_OUTPUT_FORMAT = json
GITLEAKS_REPO_SCAN_OUTPUT_FILE = ./gitleaks-repo-scan-report.json
GITLEAKS_REPO_SCAN_EXIT_CODE = 1
GITLEAKS_REPO_SCAN_ADDITIONAL_PARAMETERS :=
