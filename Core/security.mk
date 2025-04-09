##
# @file         security.mk
# @brief        Security jobs for scanning and compliance.
# @author       Bryan James
# @date         2025-04-09
#
# This mk file contains job for seccurity applications.
##

## ----------------------------------
#  Trivy Scan
## ----------------------------------


##
# @function     trivy-scan
# @brief        Wrapper for all trivy scans
# @param[in]    TRIVY_SCAN_TYPE                  Type of scan to perform. Allowed values are: `sast`, `cs`, `container`, `image`, and `repo`.
##
.PHONY: trivy-scan
trivy-scan:
	@echo "Trivy scan selected: $(TRIVY_SCAN_TYPE)"
	@if [ "$(TRIVY_SCAN_TYPE)" = "sast" ]; then \
		$(MAKE) trivy-fs-scan; \
	elif [ "$(TRIVY_SCAN_TYPE)" = "container" ] || [ "$(TRIVY_SCAN_TYPE)" = "cs" ] || [ "$(TRIVY_SCAN_TYPE)" = "image" ]; then \
		$(MAKE) trivy-image-scan; \
	elif [ "$(TRIVY_SCAN_TYPE)" = "repo" ]; then \
		$(MAKE) trivy-repo-scan; \
	else \
		echo "Unknown TRIVY_SCAN_TYPE: $(TRIVY_SCAN_TYPE)"; \
		exit 1; \
	fi

##
# @function     trivy-image-scan
# @brief        Trivy container image scanning
# @param[in]    TRIVY_IMAGE_SCAN_IMAGE_URL                  Full image name and tag for sccanning. You can also instead use `--input <TAR_FILE>` if you want to scan a tar file.
# @param[in]    TRIVY_IMAGE_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_IMAGE_SCAN_EXIT_CODE                  Exit code for trivy scan (1 for vulnerabilities detected, 0 for none)
# @param[in]    TRIVY_IMAGE_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-image-scan
trivy-image-scan:
	$(MAKE) _trivy-image-scan

.PHONY: _trivy-image-scan
_trivy-image-scan:
	@echo "Performing trivy scan..."
	trivy --version
	trivy image $(TRIVY_IMAGE_SCAN_IMAGE_URL) --format $(TRIVY_IMAGE_SCAN_OUTPUT_FORMAT) --output $(TRIVY_IMAGE_SCAN_OUTPUT_FILE) --quiet $(TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	trivy image $(TRIVY_IMAGE_SCAN_IMAGE_URL) --format $(TRIVY_IMAGE_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_IMAGE_SCAN_EXIT_CODE) $(TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "Completed trivy scan!"

##
# @function     trivy-fs-scan
# @brief        Trivy filesyste, scanning
# @param[in]    TRIVY_FS_SCAN_PATH                       Path where trivy will start scanning.
# @param[in]    TRIVY_FS_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_FS_SCAN_EXIT_CODE                  Exit code for trivy scan (1 for vulnerabilities detected, 0 for none)
# @param[in]    TRIVY_FS_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-fs-scan
trivy-fs-scan:
	$(MAKE) _trivy-fs-scan

.PHONY: _trivy-fs-scan
_trivy-fs-scan:
	@echo "Performing trivy scan..."
	trivy --version
	trivy fs $(TRIVY_FS_SCAN_PATH) --format $(TRIVY_FS_SCAN_OUTPUT_FORMAT) --output $(TRIVY_FS_SCAN_OUTPUT_FILE) --quiet $(TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS)
	trivy fs $(TRIVY_FS_SCAN_PATH) --format $(TRIVY_FS_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_FS_SCAN_EXIT_CODE) $(TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS)
	@echo "Completed trivy scan!"

##
# @function     trivy-repo-scan
# @brief        Trivy repository scanning
# @param[in]    TRIVY_REPO_SCAN_URL                        Repository URL to scan (can be remote or local repo)
# @param[in]    TRIVY_REPO_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_REPO_SCAN_EXIT_CODE                  Exit code for trivy scan (1 for vulnerabilities detected, 0 for none)
# @param[in]    TRIVY_REPO_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-repo-scan
trivy-repo-scan:
	$(MAKE) _trivy-repo-scan

.PHONY: _trivy-repo-scan
_trivy-repo-scan:
	@echo "Performing trivy scan..."
	trivy --version
	trivy repo $(TRIVY_REPO_SCAN_URL) --format $(TRIVY_REPO_SCAN_OUTPUT_FORMAT) --output $(TRIVY_REPO_SCAN_OUTPUT_FILE) --quiet $(TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS)
	trivy repo $(TRIVY_REPO_SCAN_URL) --format $(TRIVY_REPO_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_REPO_SCAN_EXIT_CODE) $(TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS)
	@echo "Completed trivy scan!"

## ----------------------------------
#  Gitleaks Scan
## ----------------------------------

##
# @function     gitleaks-dir-scan
# @brief        Gitleaks Directory Scanning
# @param[in]    GITLEAKS_DIR_SCAN_PATH                       Path where Gitleaks will scan for exposed secrets.
# @param[in]    GITLEAKS_DIR_SCAN_OUTPUT_FORMAT              Output format for Gitleaks. Allowed values are: `json`, `csv`, `junit`, `sarif`, `template`.
# @param[in]    GITLEAKS_DIR_SCAN_OUTPUT_FILE                Path and file name for report output
# @param[in]    GITLEAKS_DIR_SCAN_EXIT_CODE                  Exit code for trivy scan (1 for vulnerabilities detected, 0 for none)
# @param[in]    GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PNONY: gitleaks-dir-scan
gitleaks-dir-scan:
	$(MAKE) _gitleaks-dir-scan

.PHONY: _gitleaks-dir-scan
_gitleaks-dir-scan:
	@echo "Performing gitleaks scan..."
	gitleaks dir $(GITLEAKS_DIR_SCAN_PATH) --report-format $(GITLEAKS_DIR_SCAN_OUTPUT_FORMAT) --report-path $(GITLEAKS_DIR_SCAN_OUTPUT_FILE) --exit-code $(GITLEAKS_DIR_SCAN_EXIT_CODE) -v $(GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS)
	@echo "Completed gitleaks scan!"
