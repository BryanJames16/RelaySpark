# 📖 Pipeline Publish Jobs

## 📜 dotnet-publish
Job for publishing .NET project or solution (.NET Core).

### 🗃️ Variables
- `DOTNET_PUBLISH_SP_PATH`: Path where the project or the solution file is placed.
- `DOTNET_PUBLISH_OUTPUT_PATH`: Output directory where the binaries will be stored.
- `DOTNET_PUBLISH_VERBOSITY`: Verbosity of the command output. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
- `DOTNET_PUBLISH_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `dotnet publish`.

### 💻 Command
```Shell
# Via docker compose wrapper
make dotnet-publish

# Job Call
make _dotnet-publish
```

### 🕶️ Requirements
- Container image with .NET SDK installed.

---

## 📜 helm-package
Job for packaging Helm charts.

### 🗃️ Variables
- `HELM_CHART_PACKAGE_PATH`: Path where the helm chart is located.
- `HELM_CHART_PACKAGE_NAME`: The name of the chart. Replaces `helm_chart_name` from the Chart.yaml file.
- `HELM_CHART_PACKAGE_VERSION`: Version of the helm chart.
- `HELM_CHART_PACKAGE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to command.
- `HELM_CHART_PACKAGE_SIGNING_ENABLED`: Flag for enabling helm chart signing.
- `HELM_CHART_PACKAGE_KEY`: Signing key.
- `HELM_CHART_PACKAGE_KEYRING`: Signing keyring.

### 💻 Command
```Shell
# Via docker compose wrapper
make helm-package

# Job Call
make _helm-package
```

### 🕶️ Requirements
- Container image with helm installed.
- Set the Helm Chart name inside `Chart.yaml` to `helm_chart_name` for a variable input to be overwritten during job runtime.

---

## 📜 helm-push
Job for pushing Helm charts to repository.

### 🗃️ Variables
- `HELM_CHART_PUSH_REG_AUTH_CONFIG_ENABLED`: Flag for enabling authentication to chart registry.
- `HELM_CHART_PUSH_REG_AUTH_CONFIG`: Configuration for authentication to chart registry.
- `HELM_CHART_PUSH_PATH`: Path where the helm chart is located.
- `HELM_CHART_PUSH_REMOTE_URL`: URL where the helm chart will be pushed.
- `HELM_CHART_PUSH_ADDITIONAL_PARAMETERS`: Additional parameters to pass to the command.

### 💻 Command
```Shell
# Via docker compose wrapper
make helm-push

# Job Call
make _helm-push
```

### 🕶️ Requirements
- Container image with helm command installed.

---

## 📜 maven-package
Job for packaging maven projects.

### 🗃️ Variables
- `MAVEN_PACKAGE_PROJECT_PATH`: Path where the project is placed.
- `MAVEN_PACKAGE_VERBOSITY`: Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
- `MAVEN_PACKAGE_ADDITIONAL_PARAMETERS`: Additional parameters to pass to maven.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-package

# Job Call
make _maven-package
```

### 🕶️ Requirements
- Container image with maven installed.

---

## 📜 maven-deploy
Job for deploying maven projects.

### 🗃️ Variables
- `MAVEN_DEPLOY_PROJECT_PATH`: Path where the project is placed.
- `MAVEN_DEPLOY_VERBOSITY`: Verbosity of the command output. Available potions are: `--errors`, `--debug`, and `--quiet`.
- `MAVEN_DEPLOY_ADDITIONAL_PARAMETERS`: Additional parameters to pass to maven.

### 💻 Command
```Shell
# Via docker compose wrapper
make maven-deploy

# Job Call
make _maven-deploy
```

### 🕶️ Requirements
- Container image with maven installed.

---

## 📜 npm-publish
Publish NPM packages to repository.

### 🗃️ Variables
- `NPM_PUBLISH_PACKAGE_SPEC`: Path where the packages is located.
- `NPM_PUBLISH_ADDITIONAL_PARAMETERS`: Additional parameters to pass to maven.

### 💻 Command
```Shell
# Via docker compose wrapper
make npm-publish

# Job Call
make _npm-publish
```

### 🕶️ Requirements
- Container image with `npm` and `node` installed.

---

## 📜 tar-docker-push
Job pushing container image tar file into an image registry.

### 🗃️ Variables
- `TAR_DOCKER_PUSH_CONTAINER_IMAGE_PATH`: Location and full file name of the container image file.
- `TAR_DOCKER_PUSH_SOURCE_IMAGE_NAME`: Source image name and tag of the container image.
- `TAR_DOCKER_PUSH_DESTINATION_IMAGE_NAME`: Destination image name and tag of the container image.
- `TAR_DOCKER_PUSH_CONTAINER_SCANING_ENABLED`: Flag for enabling container signing.
- `TAR_DOCKER_PUSH_COSIGN_KEY_PATH`: Path of the Cosign key to use for image signing.
- `TAR_DOCKER_PUSH_COSIGN_ADDITIONAL_PARAMETERS`: Additional parameters for cosign container scanning.

### 💻 Command
```Shell
# Via docker compose wrapper
make tar-docker-push

# Job Call
make _tar-docker-push
```

### 🕶️ Requirements
- Container image with docker (DinD) and cosign installed.

---

## 📜 tar-crane-push
Job pushing container image tar file into an image registry using crane.

### 🗃️ Variables
- `TAR_CRANE_DOCKER_AUTH_CONFIG_ENABLED`: Enable seeding of remote authentication credentials.
- `TAR_CRANE_DOCKER_AUTH_CONFIG`: Docker authentication configuration.
- `TAR_CRANE_PUSH_CONTAINER_IMAGE_PATH`: Location and full file name of the container image file.
- `TAR_CRANE_PUSH_DESTINATION_IMAGE_NAME`: Destination image name and tag of the container image.
- `TAR_CRANE_PUSH_ADDITIONAL_PARAMETERS`: Additional parameters for crane.
- `TAR_CRANE_PUSH_CONTAINER_SIGNING_ENABLED`: Flag for enabling container signing.
- `TAR_CRANE_PUSH_COSIGN_KEY_PATH`: Path where Cosign key can be found.
- `TAR_CRANE_PUSH_SIGN_ADDITIONAL_PARAMETERS`: Additional Parameters for Cosign.

### 💻 Command
```Shell
# Via docker compose wrapper
make tar-crane-push

# Job Call
make _tar-crane-push
```

### 🕶️ Requirements
- Container image with crane and cosign installed.
