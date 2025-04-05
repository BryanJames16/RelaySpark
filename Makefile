# Include Directives

include pipeline.mk

# Pipeline Jobs
.PHONY: app-test
app-test: dotnet-test

.PHONY: build
build: dotnet-publish

.PHONY: clean
clean: dotnet-clean
