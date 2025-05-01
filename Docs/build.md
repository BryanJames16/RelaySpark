# 🛠️ Pipeline Build Jobs

## docker-build

Job for building container images using Docker

### Variables
- `CONTAINER_IMAGE_NAME`: The full container image name.
- `CONTAINER_IMAGE_TAG`: Tag of the container image to use.
- `DOCKERFILE_PATH`: Path of the `Dockerfile`.
- `CONTAINER_BUILD_ADDITIONAL_PARAMETERS`: Additional docker build parameters.

### Command
```Shell
make docker-build
```

### Requirements
- Container image with docker (DinD).

## dotnet-build

Job for building .NET application (.NET Core)

### Variables
- `DOTNET_BUILD_SP_PATH`: Path where the project or the solution file is placed.
- `DOTNET_BUILD_VERBOSITY`: Verbosity of the build. Available potions are: `q[uiet]`, `m[inimal]`, `n[ormal]`, `d[etailed]`, and `diag[nostic]`.
- `DOTNET_BUILD_ADDITIONAL_PARAMETERS`: Additional parameters to pass to `dotnet build`.

### Command
```Shell
make dotnet-build
```

### Requirements
- Container image with a .NET SDK.

## kaniko-build

Job for building container images using Kaniko executor

### Variables
- `KANIKO_BUILD_IMAGE_NAME`: The full container image name.
- `KANIKO_BUILD_IMAGE_TAG`: Tag of the container image to use.
- `KANIKO_DOCKER_AUTH_CONFIG_ENABLED`: Enable seeding of remote authentication credentials.
- `KANIKO_DOCKER_AUTH_CONFIG`: Docker authentication configuration.
- `KANIKO_DOCKERFILE_PATH` : Full path and filename of the Dockerfile.
- `KANIKO_BUILD_PROJECT_DIR` : Path of the project directory.
- `KANIKO_BUILD_ADDITIONAL_PARAMETERS` : Additional kaniko build parameters.

### Command
```Shell
make docker-build
```

### Requirements
- Container image with docker (DinD).
