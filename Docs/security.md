# 🔒 Pipeline Security Jobs

## 🔍 trivy-scan
Wrapper for all trivy scans.

### 🗃️ Variables
- `TRIVY_SCAN_TYPE`: Type of scan to perform. Allowed values are: `sast`, `cs`, `container`, `image`, and `repo`.

### 💻 Command
```Shell
make trivy-scan
```

### 🕶️ Requirements
- Container image with trivy installed.

---

## 🔍 trivy-image-scan
Trivy container image scanning.

### 🗃️ Variables
- `TRIVY_IMAGE_SCAN_IMAGE_URL`: Full image name and tag for sccanning. You can also instead use `--input <TAR_FILE>` if you want to scan a tar file.
- `TRIVY_IMAGE_SCAN_OUTPUT_FORMAT`: Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
- `TRIVY_IMAGE_SCAN_EXIT_CODE`: Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none).
- `TRIVY_IMAGE_SCAN_OUTPUT_FILE`: Output file for trivy scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make trivy-image-scan

# Job Call
make _trivy-image-scan
```

### 🕶️ Requirements
- Container image with trivy installed.

---

## 🔍 trivy-fs-scan
Trivy filesystem scanning.

### 🗃️ Variables
- `TRIVY_FS_SCAN_PATH`: Path where trivy will start scanning.
- `TRIVY_FS_SCAN_OUTPUT_FORMAT`: Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
- `TRIVY_FS_SCAN_EXIT_CODE`: Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none).
- `TRIVY_FS_SCAN_OUTPUT_FILE`: Output file for trivy scan.
- `TRIVY_FS_SCAN_ADDITIONAL_PARAMETERS`: Any additional trivy scan parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make trivy-fs-scan

# Job Call
make _trivy-fs-scan
```

### 🕶️ Requirements
- Container image with trivy installed.

---

## 🔍 trivy-repo-scan
Trivy repository scanning.

### 🗃️ Variables
- `TRIVY_REPO_SCAN_URL`: Repository URL to scan (can be remote or local repo).
- `TRIVY_REPO_SCAN_OUTPUT_FORMAT`: Output format for Trivy. Allowed values are: `table`, `json`, `template`, `sarif`, `cyclonedx`, `spdx`, `spdx-json`, `github`, and `cosign-vuln`.
- `TRIVY_REPO_SCAN_EXIT_CODE`: Exit code for trivy scan (`1` for vulnerabilities detected, `0` for none).
- `TRIVY_REPO_SCAN_OUTPUT_FILE`: Output file for trivy scan.
- `TRIVY_REPO_SCAN_ADDITIONAL_PARAMETERS`: Any additional trivy scan parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make trivy-repo-scan

# Job Call
make _trivy-repo-scan
```

### 🕶️ Requirements
- Container image with trivy installed.

---

## 🔍 gitleaks-scan
Wrapper for all gitleaks scans.

### 🗃️ Variables
- `GITLEAKS_SCAN_TYPE`: Type of scan to perform. Allowed values are: `repo`, `git`, `dir`, `file`, `directory`, or `folder`.

### 💻 Command
```Shell
make gitleaks-scan
```

### 🕶️ Requirements
- Container image with gitleaks installed.

---

## 🔍 gitleaks-dir-scan
Gitleaks directory scanning.

### 🗃️ Variables
- `GITLEAKS_DIR_SCAN_PATH`: Path where Gitleaks will scan for exposed secrets.
- `GITLEAKS_DIR_SCAN_OUTPUT_FORMAT`: Output format for Gitleaks. Allowed values are: `json`, `csv`, `junit`, `sarif`, `template`.
- `GITLEAKS_DIR_SCAN_OUTPUT_FILE`: Path and file name for report output.
- `GITLEAKS_DIR_SCAN_EXIT_CODE`: Exit code for gitleaks scan (`1` for vulnerabilities detected, `0` for none).
- `GITLEAKS_DIR_SCAN_ADDITIONAL_PARAMETERS`: Any additional gitleaks scan parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make gitleaks-dir-scan

# Job Call
make _gitleaks-dir-scan
```

### 🕶️ Requirements
- Container image with gitleaks installed.

---

## 🔍 gitleaks-repo-scan
Gitleaks git repository scanning.

### 🗃️ Variables
- `GITLEAKS_REPO_SCAN_PATH`: Path where Gitleaks will scan for exposed secrets.
- `GITLEAKS_REPO_SCAN_OUTPUT_FORMAT`: Output format for Gitleaks. Allowed values are: `json`, `csv`, `junit`, `sarif`, `template`.
- `GITLEAKS_REPO_SCAN_OUTPUT_FILE`: Path and file name for report output.
- `GITLEAKS_REPO_SCAN_EXIT_CODE`: Exit code for gitleaks scan (`1` for vulnerabilities detected, `0` for none).
- `GITLEAKS_REPO_SCAN_ADDITIONAL_PARAMETERS`: Any additional gitleaks scan parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make gitleaks-repo-scan

# Job Call
make _gitleaks-repo-scan
```

### 🕶️ Requirements
- Container image with gitleaks installed.

---

## 🔍 kubesec-scan
Wrapper for kubesec scanning.

### 🗃️ Variables
- `KUBESEC_SCAN_TYPE`: Type of scanning to be done. Valid values are `manifest` and `helm`.

### 💻 Command
```Shell
make kubesec-scan
```

### 🕶️ Requirements
- Container image with kubesec installed.

---

## 🔍 kubesec-manifest-scan
Kubernetes SAST manifest scanning.

### 🗃️ Variables
- `KUBESEC_MANIFEST_SCAN_PATH`: Path to scan YAML manifest files.
- `KUBESEC_MANIFEST_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for kubesec.

### 💻 Command
```Shell
# Via docker compose wrapper
make kubesec-manifest-scan

# Job Call
make _kubesec-manifest-scan
```

### 🕶️ Requirements
- Container image with kubesec installed.

---

## 🔍 kubesec-helm-scan
Kubernetes SAST helm scanning.

### 🗃️ Variables
- `KUBESEC_HELM_SCAN_PATH`: Path to scan helm chart.
- `KUBESEC_HELM_VALUES_SCAN_PATH`: Path to scan helm chart values.
- `KUBESEC_HELM_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for kubesec.

### 💻 Command
```Shell
# Via docker compose wrapper
make kubesec-helm-scan

# Job Call
make _kubesec-helm-scan
```

### 🕶️ Requirements
- Container image with kubesec installed.

---

## 🔍 horusec-scan
SAST scanning through Horusec.

### 🗃️ Variables
- `HORUSEC_SCAN_CONFIG_FILE_PATH`: Path where horusec configuration can be found.
- `HORUSEC_SCAN_PATH`: Path where horusec will start scanning.
- `HORUSEC_SCAN_LOG_FILE_PATH`: Path and filename of the log file.
- `HORUSEC_SCAN_LOG_LEVEL`: Log level of horusec. Valid values are: `panic`, `fatal`, `error`, `warn`, `info`, `debug`, and `trace`.
- `HORUSEC_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for horusec.

### 💻 Command
```Shell
# Via docker compose wrapper
make horusec-scan

# Job Call
make _horusec-scan
```

### 🕶️ Requirements
- Container image with horusec installed.

---

## 🔍 cosign-container-image-tar-signing
Container signing for container images in tar format.

### 🗃️ Variables
- `COSIGN_CONTAINER_SIGNING_KEY_PATH`: Path where the key can be found.
- `COSIGN_CONTAINER_IMAGE_PATH`: Path to the container image tar file.
- `COSIGN_CONTAINER_SIGNING_ADDITIONAL_PARAMETERS`: Additional parameters for cosign command.

### 💻 Command
```Shell
# Via docker compose wrapper
make cosign-container-image-tar-signing

# Job Call
make _cosign-container-image-tar-signing
```

### 🕶️ Requirements
- Container image with cosign installed.
- Security key to be used by cosign.

---

## 🔍 cosign-blob-signing
Job for blob signing through cosign.

### 🗃️ Variables
- `COSIGN_BLOB_SIGNING_KEY_PATH`: Path where the key can be found.
- `COSIGN_BLOB_FILE`: Full path and file to the blob.
- `COSIGN_BLOB_ADDITIONAL_PARAMETERS`: Additional parameters for cosign command.

### 💻 Command
```Shell
# Via docker compose wrapper
make cosign-blob-signing

# Job Call
make _cosign-blob-signing
```

### 🕶️ Requirements
- Container image with cosign installed.
- Security key to be used by cosign.

---

## 🔍 osv-scan
Wrapper job for OSV scans.

### 🗃️ Variables
- `OSV_SCAN_TYPE`: Scan type for OSV. Valid values are `container_image`, `container_tar`, `source`, and `license`.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-scan

# Job Call
make _osv-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.

---

## 🔍 osv-container-image-scan
Job for OSV conatiner image scan.

### 🗃️ Variables
- `OSV_CONTAINER_IMAGE_SCAN_IMAGE_NAME`: Container image name to be scanned.
- `OSV_CONTAINER_IMAGE_SCAN_ADDITIONAL_PARAMETERS`: Container image tag to be scanned.
- `COSIGN_BLOB_ADDITIONAL_PARAMETERS`: Additional parameters for OSV container image scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-container-image-scan

# Job Call
make _osv-container-image-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.

---

## 🔍 osv-container-tar-scan
Job for OSV conatiner tar scan.

### 🗃️ Variables
- `OSV_CONTAINER_TAR_SCAN_PATH`: Full path and file name of the container image tar.
- `OSV_CONTAINER_TAR_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for OSV container tar scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-container-tar-scan

# Job Call
make _osv-container-tar-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.

---

## 🔍 osv-source-scan
Job for OSV scan for source code repository.

### 🗃️ Variables
- `OSV_SOURCE_SCAN_PATH`: Path of the source code repository to recursively scan.
- `OSV_SOURCE_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for OSV source scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-source-scan

# Job Call
make _osv-source-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.

---

## 🔍 osv-license-scan
Job for OSV scan for source code repository licenses.

### 🗃️ Variables
- `OSV_LICENSE_SCAN_PATH`: Path of the source code repository to scan licenses.
- `OSV_LICENSE_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for OSV license scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-license-scan

# Job Call
make _osv-license-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.

---

## 🔍 osv-license-scan
Job for OSV scan for source code repository licenses.

### 🗃️ Variables
- `OSV_LICENSE_SCAN_PATH`: Path of the source code repository to scan licenses.
- `OSV_LICENSE_SCAN_ADDITIONAL_PARAMETERS`: Additional parameters for OSV license scan.

### 💻 Command
```Shell
# Via docker compose wrapper
make osv-license-scan

# Job Call
make _osv-license-scan
```

### 🕶️ Requirements
- Container image with OSV scanner installed.
