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

## 🚁 tofu-init
OpenTofu initialization job.

### 🗃️ Variables
- `TOFU_INIT_ADDITIONAL_PARAMETERS`: OpenTofu initialization additional parameters.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-init

# Job Call
make _tofu-init
```

### 🕶️ Requirements
- Container image with `OpenTofu` installed.
