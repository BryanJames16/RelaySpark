# 🧼 Pipeline Clean Jobs

## 🧹 dotnet-clean
Job for cleaning .NET project or solution (.NET Core).

### 🗃️ Variables
- `DOTNET_CLEAN_SP_PATH`: Path where the project or the solution file is placed.
- `DOTNET_CLEAN_VERBOSITY`: Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
- `DOTNET_CLEAN_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `dotnet clean`.

### 💻 Command
```Shell
# Via docker compose wrapper
make dotnet-clean

# Job Call
make _dotnet-clean
```

### 🕶️ Requirements
- Container image with .NET SDK installed.

---

## 🧹 maven-clean
Job for cleaning Maven projects.

### 🗃️ Variables
- `MAVEN_CLEAN_PROJECT_PATH`: Path where the project is placed.
- `MAVEN_CLEAN_VERBOSITY`: Path where the project is placed.
- `MAVEN_CLEAN_ADDITIONAL_PARAMETERS`: Additional parameters to pass to maven.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-clean

# Job Call
make _maven-clean
```

### 🕶️ Requirements
- Container image with Maven installed.

---

## 🧹 terraform-destroy
Job for performing terraform destroy.

### 🗃️ Variables
- `TERRAFORM_DESTROY_ADDITIONAL_PARAMETERS`: Additional parameters to pass to terraform.

### 💻 Command
```Shell
# Via docker compose wrapper
make terraform-destroy

# Job Call
make _terraform-destroy
```

### 🕶️ Requirements
- Container image with terraform installed.

---

## 🧹 tofu-destroy
Job for performing tofu destroy.

### 🗃️ Variables
- `TOFU_DESTROY_ADDITIONAL_PARAMETERS`: Additional parameters to pass to OpenTofu.

### 💻 Command
```Shell
# Via docker compose wrapper
make tofu-destroy

# Job Call
make _tofu-destroy
```

### 🕶️ Requirements
- Container image with OpenTofu installed, specifically `tofu` command.
