##
# @file         security.mk
# @brief        Security jobs for scanning and compliance.
# @author       Bryan James
# @date         2025-04-09
#
# This mk file contains job for seccurity applications.
##

##
# @function     trivy-iamge-scan
# @brief        Trivy container image scanning
# @param[in]    TRIVY_IMAGE_SCAN_IMAGE_URL                  Full image name and tag for sccanning. You can also instead use `--input <TAR_FILE>` if you want to scan a tar file.
# @param[in]    TRIVY_IMAGE_SCAN_OUTPUT_FORMAT              Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
# @param[in]    TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS      Any additional trivy image scan parameters
##
.PHONY: trivy-image-scan
trivy-image-scan:
	make _trivy-image-scan

.PHONY: _trivy-image-scan
_trivy-image-scan:
	@echo "Performing trivy scan..."
	trivy --version
	trivy image $(TRIVY_IMAGE_SCAN_IMAGE_URL) --format $(TRIVY_IMAGE_SCAN_OUTPUT_FORMAT) $(TRIVY_IMAGE_SCAN_ADDITIONAL_PARAMETERS)
	@echo "Completed triv scan!"
