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
