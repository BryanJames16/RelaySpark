##
# @file         security.mk
# @brief        Security jobs for scanning and compliance.
# @author       Bryan James
# @date         2025-04-09
#
# This mk file contains job for security applications.
##

## ----------------------------------
#  Trivy Scan
## ----------------------------------

##
# @function     trivy-scan
# @brief        Wrapper for all trivy scans.
# @param[in]    TRIVY_SCAN_TYPE                  Type of scan to perform. Allowed values are: `sast`, `cs`, `container`, `image`, and `repo`.
##
.PHONY: trivy-scan
trivy-scan:
	@echo "🧭 Trivy scan selected: $(TRIVY_SCAN_TYPE)"
	@if [ "$(TRIVY_SCAN_TYPE)" = "sast" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) trivy-fs-scan; \
	elif [ "$(TRIVY_SCAN_TYPE)" = "container" ] || [ "$(TRIVY_SCAN_TYPE)" = "cs" ] || [ "$(TRIVY_SCAN_TYPE)" = "image" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) trivy-image-scan; \
	elif [ "$(TRIVY_SCAN_TYPE)" = "repo" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) trivy-repo-scan; \
	else \
		echo "❌ Unknown TRIVY_SCAN_TYPE: $(TRIVY_SCAN_TYPE)"; \
		exit 1; \
	fi

##
# @function     trivy-image-scan
# @brief        Trivy container image scanning.
# @param[in]    TRIVY_IMAGE_SCAN_IMAGE_URL                  Full image name and tag for sccanning. You can also instead use `--input <TAR_FILE>` if you want to scan a tar file.
# @param[in]    TRIVY_IMAGE_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_IMAGE_SCAN_EXIT_CODE                  Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none).
# @param[in]    TRIVY_IMAGE_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-image-scan
trivy-image-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _trivy-image-scan

.PHONY: _trivy-image-scan
_trivy-image-scan:
	@echo "🔍 Performing trivy scan..."
	trivy --version
	trivy image $(TRIVY_IMAGE_SCAN_IMAGE_URL) --format $(TRIVY_IMAGE_SCAN_OUTPUT_FORMAT) --output $(TRIVY_IMAGE_SCAN_OUTPUT_FILE) --quiet $(TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	trivy image $(TRIVY_IMAGE_SCAN_IMAGE_URL) --format $(TRIVY_IMAGE_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_IMAGE_SCAN_EXIT_CODE) $(TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed trivy scan!"

##
# @function     trivy-fs-scan
# @brief        Trivy filesystem scanning.
# @param[in]    TRIVY_FS_SCAN_PATH                       Path where trivy will start scanning.
# @param[in]    TRIVY_FS_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_FS_SCAN_EXIT_CODE                  Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none)
# @param[in]    TRIVY_FS_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-fs-scan
trivy-fs-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _trivy-fs-scan

.PHONY: _trivy-fs-scan
_trivy-fs-scan:
	@echo "🔍 Performing trivy scan..."
	trivy --version
	trivy fs $(TRIVY_FS_SCAN_PATH) --format $(TRIVY_FS_SCAN_OUTPUT_FORMAT) --output $(TRIVY_FS_SCAN_OUTPUT_FILE) --quiet $(TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS)
	trivy fs $(TRIVY_FS_SCAN_PATH) --format $(TRIVY_FS_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_FS_SCAN_EXIT_CODE) $(TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed trivy scan!"

##
# @function     trivy-repo-scan
# @brief        Trivy repository scanning.
# @param[in]    TRIVY_REPO_SCAN_URL                        Repository URL to scan (can be remote or local repo).
# @param[in]    TRIVY_REPO_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_REPO_SCAN_EXIT_CODE                  Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none)
# @param[in]    TRIVY_REPO_SCAN_OUTPUT_FILE                Output file for trivy scan.
# @param[in]    TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy scan parameters.
##
.PHONY: trivy-repo-scan
trivy-repo-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _trivy-repo-scan

.PHONY: _trivy-repo-scan
_trivy-repo-scan:
	@echo "🔍 Performing trivy scan..."
	trivy --version
	trivy repo $(TRIVY_REPO_SCAN_URL) --format $(TRIVY_REPO_SCAN_OUTPUT_FORMAT) --output $(TRIVY_REPO_SCAN_OUTPUT_FILE) --quiet $(TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS)
	trivy repo $(TRIVY_REPO_SCAN_URL) --format $(TRIVY_REPO_SCAN_OUTPUT_FORMAT) --exit-code $(TRIVY_REPO_SCAN_EXIT_CODE) $(TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed trivy scan!"

## ----------------------------------
#  Gitleaks Scan
## ----------------------------------

##
# @function     gitleaks-scan
# @brief        Wrapper for all gitleaks scans
# @param[in]    GITLEAKS_SCAN_TYPE                Type of scan to perform. Allowed values are: `repo`, `git`, `dir`, `file`, `directory`, or `folder`.
##
.PHONY: gitleaks-scan
gitleaks-scan:
	@echo "🧭 GitLeaks scan selected: $(GITLEAKS_SCAN_TYPE)"
	@if [ "$(GITLEAKS_SCAN_TYPE)" = "dir" ] || [ "$(GITLEAKS_SCAN_TYPE)" = "directory" ] || [ "$(GITLEAKS_SCAN_TYPE)" = "folder" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) gitleaks-dir-scan; \
	elif [ "$(GITLEAKS_SCAN_TYPE)" = "repo" ] || [ "$(GITLEAKS_SCAN_TYPE)" = "git" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) gitleaks-repo-scan; \
	else \
		echo "❌ Unknown GITLEAKS_SCAN_TYPE: $(GITLEAKS_SCAN_TYPE)"; \
		exit 1; \
	fi

##
# @function     gitleaks-dir-scan
# @brief        Gitleaks directory scanning.
# @param[in]    GITLEAKS_DIR_SCAN_PATH                       Path where Gitleaks will scan for exposed secrets.
# @param[in]    GITLEAKS_DIR_SCAN_OUTPUT_FORMAT              Output format for Gitleaks. Allowed values are: `json`, `csv`, `junit`, `sarif`, `template`.
# @param[in]    GITLEAKS_DIR_SCAN_OUTPUT_FILE                Path and file name for report output.
# @param[in]    GITLEAKS_DIR_SCAN_EXIT_CODE                  Exit code for gitleaks scan (`1` for vulnerabilities detected, `0` for none).
# @param[in]    GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS      Any additional gitleaks scan parameters.
##
.PHONY: gitleaks-dir-scan
gitleaks-dir-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _gitleaks-dir-scan

.PHONY: _gitleaks-dir-scan
_gitleaks-dir-scan:
	@echo "🔍 Performing gitleaks scan..."
	gitleaks dir $(GITLEAKS_DIR_SCAN_PATH) --report-format $(GITLEAKS_DIR_SCAN_OUTPUT_FORMAT) --report-path $(GITLEAKS_DIR_SCAN_OUTPUT_FILE) --exit-code $(GITLEAKS_DIR_SCAN_EXIT_CODE) -v $(GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed gitleaks scan!"

##
# @function     gitleaks-repo-scan
# @brief        Gitleaks git repository scanning.
# @param[in]    GITLEAKS_REPO_SCAN_PATH                       Path where Gitleaks will scan for exposed secrets.
# @param[in]    GITLEAKS_REPO_SCAN_OUTPUT_FORMAT              Output format for Gitleaks. Allowed values are: `json`, `csv`, `junit`, `sarif`, `template`.
# @param[in]    GITLEAKS_REPO_SCAN_OUTPUT_FILE                Path and file name for report output.
# @param[in]    GITLEAKS_REPO_SCAN_EXIT_CODE                  Exit code for gitleaks scan (`1` for vulnerabilities detected, `0` for none).
# @param[in]    GITLEAKS_REPO_SCAN_ADDITIONAL_PARAMETERS      Any additional gitleaks scan parameters.
##
.PHONY: gitleaks-repo-scan
gitleaks-repo-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _gitleaks-repo-scan

.PHONY: _gitleaks-repo-scan
_gitleaks-repo-scan:
	@echo "🔍 Performing gitleaks scan..."
	gitleaks dir $(GITLEAKS_REPO_SCAN_PATH) --report-format $(GITLEAKS_REPO_SCAN_OUTPUT_FORMAT) --report-path $(GITLEAKS_REPO_SCAN_OUTPUT_FILE) --exit-code $(GITLEAKS_REPO_SCAN_EXIT_CODE) -v $(GITLEAKS_REPO_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed gitleaks scan!"

## ----------------------------------
#  Kubesec Scan
## ----------------------------------

##
# @function     kubesec-scan
# @brief        Wrapper for kubesec scanning.
# @param[in]    KUBESEC_SCAN_TYPE                     Type of scanning to be done. Valid values are `manifest` and `helm`.
##
.PHONY: kubesec-scan
kubesec-scan:
	@echo "🧭 Kubesec scan selected: $(KUBESEC_SCAN_TYPE)"
	@if [ "$(KUBESEC_SCAN_TYPE)" = "manifest" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) kubesec-manifest-scan; \
	elif [ "$(KUBESEC_SCAN_TYPE)" = "helm" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) kubesec-helm-scan; \
	else \
		echo "❌ Unknown KUBESEC_SCAN_TYPE: $(KUBESEC_SCAN_TYPE)"; \
		exit 1; \
	fi

##
# @function     kubesec-manifest-scan
# @brief        Kubernetes SAST manifest scanning.
# @param[in]    KUBESEC_MANIFEST_SCAN_PATH                     Path to scan YAML manifest files.
# @param[in]    KUBESEC_MANIFEST_SCAN_ADDITIONAL_PARAMETERS    Additional parameters for kubesec.
##
.PHONY: kubesec-manifest-scan
kubesec-manifest-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _kubesec-manifest-scan

.PHONY: _kubesec-manifest-scan
_kubesec-manifest-scan:
	@echo "🔍 Performing Kubesec scan..."
	@find $(KUBESEC_MANIFEST_SCAN_PATH) -type f \( -name "*.yaml" -o -name "*.yml" \) | while read file; do \
		echo "▶️  Scanning $$file"; \
		kubesec scan "$$file" $(KUBESEC_MANIFEST_SCAN_ADDITIONAL_PARAMETERS) || echo "❌ Scan failed for: $$file"; \
	done
	@echo "✅ Completed Kubesec scan!"

##
# @function     kubesec-helm-scan
# @brief        Kubernetes SAST helm scanning.
# @param[in]    KUBESEC_HELM_SCAN_PATH                     Path to scan helm chart
# @param[in]    KUBESEC_HELM_VALUES_SCAN_PATH              Path to scan helm chart values.
# @param[in]    KUBESEC_HELM_SCAN_ADDITIONAL_PARAMETERS    Additional parameters for kubesec.
##
.PHONY: kubesec-helm-scan
kubesec-helm-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _kubesec-helm-scan

.PHONY: _kubesec-helm-scan
_kubesec-helm-scan:
	@echo "🔍 Performing Kubesec helm scan..."
	helm template -f $(KUBESEC_HELM_VALUES_SCAN_PATH) $(KUBESEC_HELM_SCAN_PATH) | kubesec scan /dev/stdn $(KUBESEC_HELM_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed Kubesec helm scan!"

## ----------------------------------
#  Horusec
## ----------------------------------

##
# @function     horusec-scan
# @brief        SAST scanning through Horusec.
# @param[in]    HORUSEC_SCAN_CONFIG_FILE_PATH               Path where horusec configuration can be found.
# @param[in]    HORUSEC_SCAN_PATH                           Path where horusec will start scanning.
# @param[in]    HORUSEC_SCAN_LOG_FILE_PATH                  Path and filename of the log file.
# @param[in]    HORUSEC_SCAN_LOG_LEVEL                      Log level of horusec. Valid values are: `panic`, `fatal`, `error`, `warn`, `info`, `debug`, and `trace`.
# @param[in]    HORUSEC_SCAN_ADDITIONAL_PARAMETERS          Additional parameters for horusec.
##
.PHONY: horusec-scan
horusec-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _horusec-scan

.PHONY: _horusec-scan
_horusec-scan:
	@echo "🔍 Performing horusec scanning..."
	horusec version
	horusec start -p="$(HORUSEC_SCAN_CONFIG_FILE_PATH)" --log-file-path $(HORUSEC_SCAN_LOG_FILE_PATH) --log-level $(HORUSEC_SCAN_LOG_LEVEL) $(HORUSEC_SCAN_ADDITIONAL_PARAMETERS) $(HORUSEC_SCAN_PATH)
	@echo "✅ Completed horusec scanning!"

## ----------------------------------
#  Cosign
## ----------------------------------

##
# @function     cosign-container-image-tar-signing
# @brief        Container signing for container images in tar format.
# @param[in]    COSIGN_CONTAINER_SIGNING_KEY_PATH                     Path where the key can be found.
# @param[in]    COSIGN_CONTAINER_IMAGE_PATH                           Path to the container image tar file.
# @param[in]    COSIGN_CONTAINER_SIGNING_ADDITIONAL_PARAMETERS        Additional parameters for cosign command.
##
.PHONY: cosign-container-image-tar-signing
cosign-container-image-tar-signing:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cosign-container-image-tar-signing

.PHONY: _cosign-container-image-tar-signing
_cosign-container-image-tar-signing:
	@echo "✒️ Performing container scanning..."
	cosign sign-blob --key $(COSIGN_CONTAINER_SIGNING_KEY_PATH) $(COSIGN_CONTAINER_SIGNING_ADDITIONAL_PARAMETERS) $(COSIGN_CONTAINER_IMAGE_PATH)
	@echo "✅ Completed container signing!"

##
# @function     cosign-blob-signing
# @brief        Job for blob signing through cosign.
# @param[in]    COSIGN_BLOB_SIGNING_KEY_PATH                     Path where the key can be found.
# @param[in]    COSIGN_BLOB_FILE                                 Full path and file to the blob.
# @param[in]    COSIGN_BLOB_ADDITIONAL_PARAMETERS                Additional parameters for cosign command.
##
.PHONY: cosign-blob-signing
cosign-blob-signing:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _cosign-blob-signing

.PHONY: _cosign-blob-signing
_cosign-blob-signing:
	@echo "✒️ Performing blob signing..."
	cosign sign-blob --key $(COSIGN_BLOB_SIGNING_KEY_PATH) $(COSIGN_BLOB_ADDITIONAL_PARAMETERS) $(COSIGN_BLOB_PATH)
	@echo "✅ Completed blob signing!"

## ----------------------------------
#  Google OSV Scanner
## ----------------------------------

##
# @function     osv-scan
# @brief        Wrapper job for OSV scans.
# @param[in]    OSV_SCAN_TYPE                           Scan type for OSV. Valid values are `container_image`, `container_tar`, `source`, and `license`.
##
.PHONY: osv-container-tar-scan
osv-scan:
	@echo "🧭 OSV scan selected: $(OSV_SCAN_TYPE)"
	@if [ "$(OSV_SCAN_TYPE)" = "container_image" ] || [ "$(OSV_SCAN_TYPE)" = "ci" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) osv-container-image-scan; \
	elif [ "$(OSV_SCAN_TYPE)" = "container_tar" ] || [ "$(OSV_SCAN_TYPE)" = "ct" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) osv-container-tar-scan; \
	elif [ "$(OSV_SCAN_TYPE)" = "source" ] || [ "$(OSV_SCAN_TYPE)" = "repo" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) osv-source-scan; \
	elif [ "$(OSV_SCAN_TYPE)" = "license" ] || [ "$(OSV_SCAN_TYPE)" = "lic" ]; then \
		$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) osv-license-scan; \
	else \
		echo "❌ Unknown OSV_SCAN_TYPE: $(OSV_SCAN_TYPE)"; \
		exit 1; \
	fi

##
# @function     osv-container-image-scan
# @brief        Job for OSV conatiner image scan.
# @param[in]    OSV_CONTAINER_IMAGE_SCAN_IMAGE_NAME                     Container image name to be scanned.
# @param[in]    OSV_CONTAINER_IMAGE_SCAN_IMAGE_TAG                      Container image tag to be scanned.
# @param[in]    OSV_CONTAINER_IMAGE_SCAN_ADDITIONAL_PARAMETERS          Additional parameters for OSV container image scan.
##
.PHONY: osv-container-image-scan
osv-container-image-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _osv-container-image-scan

.PHONY: _osv-container-image-scan
_osv-container-image-scan:
	@echo "🔍 Performing OSV container image scanning..."
	osv-scanner scan image $(OSV_CONTAINER_IMAGE_SCAN_IMAGE_NAME):$(OSV_CONTAINER_IMAGE_SCAN_IMAGE_TAG) $(OSV_CONTAINER_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed OSV container image scanning!"

##
# @function     osv-container-tar-scan
# @brief        Job for OSV conatiner tar scan.
# @param[in]    OSV_CONTAINER_TAR_SCAN_PATH                           Full path and file name of the container image tar.
# @param[in]    OSV_CONTAINER_TAR_SCAN_ADDITIONAL_PARAMETERS          Additional parameters for OSV container tar scan.
##
.PHONY: osv-container-tar-scan
osv-container-tar-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _osv-container-tar-scan

.PHONY: _osv-container-tar-scan
_osv-container-tar-scan:
	@echo "🔍 Performing OSV container image (tar) scanning..."
	osv-scanner scan image --archive $(OSV_CONTAINER_TAR_SCAN_PATH) $(OSV_CONTAINER_TAR_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed OSV container image (tar) scanning!"

##
# @function     osv-source-scan
# @brief        Job for OSV scan for source code repository.
# @param[in]    OSV_SOURCE_SCAN_PATH                     Path of the source code repository to recursively scan.
# @param[in]    OSV_SOURCE_SCAN_ADDITIONAL_PARAMETERS    Additional parameters for OSV source scan.
##
.PHONY: osv-source-scan
osv-source-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _osv-source-scan

.PHONY: _osv-source-scan
_osv-source-scan:
	@echo "🔍 Performing OSV source scanning..."
	osv-scanner scan source -r $(OSV_SOURCE_SCAN_PATH) $(OSV_SOURCE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed OSV source scanning!"

##
# @function     osv-license-scan
# @brief        Job for OSV scan for source code repository licenses.
# @param[in]    OSV_LICENSE_SCAN_PATH                     Path of the source code repository to scan licenses.
# @param[in]    OSV_LICENSE_SCAN_ADDITIONAL_PARAMETERS    Additional parameters for OSV license scan.
##
.PHONY: osv-license-scan
osv-license-scan:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _osv-license-scan

.PHONY: _osv-license-scan
_osv-license-scan:
	@echo "🔍 Performing OSV license scanning..."
	osv-scanner scan --licenses $(OSV_LICENSE_SCAN_PATH) $(OSV_LICENSE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "✅ Completed OSV license scanning!"
