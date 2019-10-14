IMAGE=openlaw/protocore

image:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE) .

test:
	@./test/test.sh

replace-golden-files:
	rm -r ./test/expect
	cp -r ./test/build ./test/expect

.PHONY: image test golden
