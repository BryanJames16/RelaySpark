<div align="center">

  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="0">
    <defs>
      <filter id="glow">
        <feGaussianBlur stdDeviation="15" result="coloredBlur"/>
        <feMerge>
          <feMergeNode in="coloredBlur"/>
          <feMergeNode in="SourceGraphic"/>
        </feMerge>
      </filter>
    </defs>
  </svg>

  <link href="https://fonts.googleapis.com/css?family=Onest&display=swap" rel="stylesheet">

  <h1 style="font-family: Onest, monospace; color: black; ">RelaySpark ⚡</h1>
  <h6>Collection of pipeline jobs coded in three musketeers pattern.</h6>

  [![License](https://img.shields.io/github/license/BryanJames16/RelaySpark)](LICENSE)
  [![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg?style=flat)](./CONTRIBUTING.md)

</div>

---

# 📜 Introduction

Pipeline are essential to implementing the  automation of DevOps practices and frameworks. They power the core automation in which our workflows run, and has been a staple to the DevOps implementation of organizations, big or small.

Maintaining a reusable pipeline and jobs speeds up the development process and automation. However as of the moment, there are no single tool that unifies definition of pipeline across different platforms and CI/CD tools.

**RelaySpark** offers a way to define pipelines and reusable jobs you can use to make your pipeline reusable. RelaySpark uses *three musketeers* pattern to define the jobs. This makes your pipeline jobs reusable and portable to CI/CD platforms. In fact, you don't even need a CI/CD platform to run the jobs!

# 🗡️ Three Musketeers Pattern

Three Musketeers is a software development pattern for repeatability and consistency. This pattern aims to provide consistency, control, and confidence to your pipelines. Three Musketeers are powered by three tools (hence the name):

1. **[Make](https://www.gnu.org/software/make/)** - Contains your main script. Make contains the logic of your jobs.
2. **[Docker](https://docs.docker.com/get-started/introduction/)** - The heart of your portability. Docker ensures that you can execute tasks with the same configuration as it was on different environments.
3. **[Compose](https://docs.docker.com/compose/)** - Allows scaffolding of Docker commands making it cleaner and easier to manage.

You can read more about Three Musketeers pattern [here](https://3musketeers.pages.dev/guide/).

## 🤝 Contributing

Contributions are greatly appreciated and needed. You can read more about contribution guidelines on [CONTRIBUTING.md](./CONTRIBUTING.md)

## 📚 Documentation

You can view the current reference documentation on [this link](./Docs/main.md).

## 🚀 Quick Start

A consuming repository can vendor or sparse-clone RelaySpark, include `pipeline.mk`, and then set only the variables it needs:

```make
# Makefile in your application repository
include .relayspark/pipeline.mk

CONTAINER_COMMAND_SERVICE := ci
NPM_BUILD_DIRECTORY := ./
NPM_BUILD_INSTALL_ADDITIONAL_PARAMETERS := --prefer-offline
NPM_BUILD_ADDITIONAL_PARAMETERS := -- --configuration production

.PHONY: ci-build
ci-build: npm-build
```

Then run:

```bash
make ci-build
```

If your pipeline needs project-specific behavior, keep the shared RelaySpark job and wrap or override it in your own `Makefile`:

```make
include .relayspark/pipeline.mk

.PHONY: release-package
release-package:
	@echo "Preparing release metadata..."
	$(MAKE) _archive-publish ARCHIVE_PUBLISH_ARCHIVE_TYPE=tar ARCHIVE_PUBLISH_OUTPUT_NAME=release
```

RelaySpark defaults are intentionally override-friendly. Pipeline authors can replace variables, compose new targets around the underscored jobs, or fully redefine a target when a workflow needs custom behavior.

# 📄 License
MIT License - Copyright (c) 2026 Bryan James
