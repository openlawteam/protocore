IMAGE=openlaw/protocore

image:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE) .
