# RelaySpark ⚡
Collection of pipeline jobs coded in three musketeers pattern.

## 📜 Overview
Pipeline are essential to implementing the  automation of DevOps practices and frameworks. They power the core automation in which our workflows run, and has been a staple to the DevOps implementation of organizations, big or small.

Maintaining a reusable pipeline and jobs speeds up the development process and automation. However as of the moment, there are no single tool that unifies definition of pipeline across different platforms and CI/CD tools.

**RelaySpark** offers a way to define pipelines and reusable jobs you can use to make your pipeline reusable. RelaySpark uses *three musketeers* pattern to define the jobs. This makes your pipeline jobs reusable and portable to CI/CD platforms. In fact, you don't even need a CI/CD platform to run the jobs!

## 🧰 Usage
RelaySpark is meant to be cloned thinly on your pipeline and cached between jobs. This will ensure that you can minimize bandwidth costs and consumption within your pipeline run. On a high-level the workflow looks like this:

```text
╔══════════════════╗
║     Prepare      ║ --> Preparation jobs and cloning RelaySpark.
╚══════════════════╝
         |
         V
╔══════════════════╗
║      Cache       ║ --> Cache the codes and dependencies.
╚══════════════════╝
         |
         V
╔══════════════════╗
║     Pipeline     ║ --> Executing pipeline jobs.
╚══════════════════╝
         |
         V
╔══════════════════╗
║     Clean Up     ║ --> Execution clean up.
╚══════════════════╝
```

### 📋 Prerequisites
In order for the jobs to properly run, the tools the job require needs to be existing. You can do this either through a container image (preferred) or by installing the tool on your host. Container images will need to have `make` and `docker` to be existing to run the jobs. Instead of using `docker`, you can also instead use a custom container image directly if your pipeline tool permits.

### 🛠️ Using Jobs
1. **Using `docker compose` wrapper**: The job should have access to `docker compose` and `make` to be able to run the jobs properly. This is ideal if you are running a `DinD` setup and wants to configure services for your jobs. To use this, you can use jobs without an underscore prefix.
2. **Directly calling the jobs**: This is ideal for pipelines who have capabilities of using custom container images during runtime. To use this, use the jobs with underscore prefix.

## 🗃️ Default Variables
There are default initial variables you may need to define on your `Makefile` or environment variables for proper usage:
- `MAKE` : The `make` command to use. Default is `make`.
- `CONTAINER_COMMAND_BASE` : Container run command. Default is `docker compose run`.
- `CONTAINER_COMMAND_PARAMETER` : Parameters to pass to `CONTAINER_COMMAND_BASE`. Default is `--rm`.
- `CONTAINER_COMMAND_SERVICE` : Compose service to run. Default is `alpine`.

## 📚 Job References

You can refer to these files for job references:
- 🛠️ [Build Jobs](./build.md)
- 🧼 [Clean Jobs](./clean.md)
- 📖 [Publish Jobs](./publish.md)
- 🔒 [Security Jobs](./security.md)
- 🚁 [Startup Jobs](./startup.md)
- 🧪 [Test Jobs](./test.md)
