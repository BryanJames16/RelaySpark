.PHONY: docker-build
docker-build:
	make _docker-build

.PHONY: _docker-build
_docker-build:
	@echo "Performing docker build..."
	docker build -t $(CONTAINER_IMAGE_NAME):$(CONTAINER_IMAGE_TAG) $(DOCKERFILE_PATH) $(CONTAINER_BUILD_ADDITIONAL_PARAMETERS)
	@echo "Completed docker build!"
