GO_DIST    := go
JS_DIST    := js
SCALA_DIST := scala

DIST_DIRS = $(GO_DIST) $(JS_DIST) $(SCALA_DIST)
$(DIST_DIRS):
	mkdir -p $@

SAMPLES = README.md \
	$(GO_DIST)/helloworld.pb.go \
	$(JS_DIST)/helloworld_pb.js \
	$(JS_DIST)/helloworld_pb.d.ts

$(SAMPLES): helloworld.proto $(DIST_DIRS)
	docker run --rm -it \
		-v "$$(pwd)":/src \
		openlaw/protocore protoc \
			--go_out=plugins=grpc:$(GO_DIST) \
			--js_out=import_style=commonjs,binary:$(JS_DIST) \
			--ts_out=$(JS_DIST) \
			--scala_out=$(SCALA_DIST) \
			--doc_out=. --doc_opt=markdown,README.md \
			$<

.DEFAULT_GOAL := all
all: $(SAMPLES)

clobber:
	rm -rf $(SAMPLES) $(DIST_DIRS)
