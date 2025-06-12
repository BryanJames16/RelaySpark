# 🚁 Pipeline Startup Jobs

## 🚁 startup
Start up banner for RelaySpark.

### 🗃️ Variables
No variables available for this job.

### 💻 Command
```Shell
# Via docker compose wrapper
make startup
```

### 🕶️ Requirements
No special requirements for this job.

---

## 🚁 print-echo
Print a specific passed string.

### 🗃️ Variables
- `ECHO_VAR`: Variable to echo.

### 💻 Command
```Shell
# Via docker compose wrapper
make print-echo
```

### 🕶️ Requirements
No special requirements for this job.

---

## 🚁 relayspark-clone
Job for thin-cloning relayspark.

### 🗃️ Variables
- `RELAYSPARK_GIT_URL`: Git URL for RelaySpark.
- `RELAYSPARK_FOLDER_FILE`: Folders and file to clone.

### 💻 Command
```Shell
# Via docker compose wrapper
make relayspark-clone

# Job Call
make _relayspark-clone
```

### 🕶️ Requirements
- Container image with `git` installed.

---

## 🚁 go-init
Initialize go repository.

### 🗃️ Variables
- `GO_INIT_PATH`: Full path or URL of your Go module.
- `GO_INIT_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `got mod init`.
- `GO_INIT_TIDY_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `got mod tidy`.

### 💻 Command
```Shell
# Via docker compose wrapper
make go-init

# Job Call
make _go-init
```

### 🕶️ Requirements
- Container image with `go` installed.

---

## 🚁 terraform-init
Terraform initialization job.

### 🗃️ Variables
- `TERRAFORM_INIT_ENABLE_CLEAN_FOLDER`: Flag for enabling clean up of .terraform and .tofu folders.
- `TERRAFORM_INIT_ENABLE_TF_CREDS`: Flag for enabling Terraform credentials.
- `TERRAFORM_INIT_TF_CREDS`: Terraform credentials.
- `TERRAFORM_INIT_ENABLE_TF_RC`: Flag for enabling Terraform remote credentials.
- `TERRAFORM_INIT_TF_RC`: Terraform remote credentials
- `TERRAFORM_INIT_BACKEND_CONFIG_FILE`: Full path and file name of Terraform backend config file.
- `TERRAFORM_INIT_ADDITIONAL_PARAMETERS`: Terraform initialization additional parameters.
- `TERRAFORM_INIT_ENABLE_WORKSPACE`: Flag for enabling Terraform workspace.
- `TERRAFORM_INIT_TARGET_WORKSPACE`: Target workspace name for the job.

### 💻 Command
```Shell
# Via docker compose wrapper
make terraform-init

# Job Call
make _terraform-init
```

### 🕶️ Requirements
- Container image with `terraform` installed.

---

## 🚁 tofu-init
OpenTofu initialization job.

### 🗃️ Variables
- `TOFU_INIT_ENABLE_CLEAN_FOLDER`: Flag for enabling clean up of .terraform and .tofu folders.
- `TOFU_INIT_ENABLE_TF_CREDS`: Flag for enabling OpenTofu credentials.
- `TOFU_INIT_TF_CREDS`: OpenTofu credentials.
- `TOFU_INIT_ENABLE_TF_RC`: Flag for enabling OpenTofu remote credentials.
- `TOFU_INIT_TF_RC`: OpenTofu remote credentials
- `TOFU_INIT_BACKEND_CONFIG_FILE`: Full path and file name of OpenTofu backend config file.
- `TOFU_INIT_ADDITIONAL_PARAMETERS`: OpenTofu initialization additional parameters.
- `TOFU_INIT_ENABLE_WORKSPACE`: Flag for enabling OpenTofu workspace.
- `TOFU_INIT_TARGET_WORKSPACE`: Target workspace name for the job.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-init

# Job Call
make _tofu-init
```

### 🕶️ Requirements
- Container image with `OpenTofu` installed.
