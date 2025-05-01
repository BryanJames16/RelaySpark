# 📖 Pipeline Publish Jobs

## 📜 dotnet-publish

Job for publishing .NET project or solution (.NET Core).

### 🗃️ Variables
- `DOTNET_PUBLISH_SP_PATH`: Path where the project or the solution file is placed.
- `DOTNET_PUBLISH_OUTPUT_PATH`: Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
- `DOTNET_PUBLISH_VERBOSITY`: Additional parameters to pass to `dotnet clean`.

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
