# SCALA PLUGIN PART DEUX
#
# A native release is now in progress! See https://github.com/scalapb/ScalaPB/issues/637
#
# TODO: potentially update this once released (0.9.2?) with naming issues ironed out.
FROM alpine:latest as scala-builder
RUN apk add --no-cache wget zip binutils upx

ARG REPO_ROOT=https://github.com/scalapb/ScalaPB
ARG VERSION=0.9.1
ARG PLATFORM=linux-x86_64
ENV DOWNLOAD_FILE=protoc-gen-scalapb-${VERSION}-${PLATFORM}.zip
ENV DOWNLOAD_URL=${REPO_ROOT}/releases/download/v${VERSION}/${DOWNLOAD_FILE}

WORKDIR /dist
RUN wget --quiet ${DOWNLOAD_URL} \
    && unzip ${DOWNLOAD_FILE} \
    && strip protoc-gen-scalapb \
    && upx protoc-gen-scalapb

# GO PLUGIN
#
# It is trivially fast to just compile our own optimized and stripped binary
# distribution of the go protoc plugin, so just do that instead of messing with
# finding a binary distribution we like.
FROM golang:1.12-alpine as go-builder
RUN apk add --no-cache git upx
ENV GO111MODULE=on
RUN go get -ldflags="-s -w" \
    github.com/golang/protobuf/protoc-gen-go@v1.3.2 \
    github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@v1.3.0
RUN upx /go/bin/*

# TYPESCRIPT PLUGIN ALTERNATIVE
#
# Written in NodeJS, so I don't see an obvious way around having node on the
# final image, but we can do this in a build stage to keep it concurrent and
# since we dont require NPM itself on the final version.
#
# Future of plugin: https://github.com/improbable-eng/ts-protoc-gen/issues/145
#
# UPDATE: use nexe to create an embedded single file version with node, so that
# we only need to worry about a single file on the final image. This seems to
# create a ~40mb file, whereas alpine nodejs claims to be ~26mb and the module
# itself is only ~1.5mb -- however having a single file makes it easier to deal
# with and UPX compress it later which will be smaller, so we deal with some
# upfront cost here.
FROM node:10-alpine as ts-builder
RUN apk add --no-cache upx
RUN mkdir -p /dist
RUN npm install --unsafe-perm -g ts-protoc-gen nexe
WORKDIR /usr/local/lib/node_modules/ts-protoc-gen/lib
RUN nexe \
    --output /dist/protoc-gen-ts \
    --target alpine-x64-10.15.3 \
    index.js
# RUN upx /dist/*
# ^^ some issues with strippping nexe binaries, TODO: resolve this
# https://github.com/nexe/nexe/issues/523

# FINAL IMAGE
FROM alpine:latest
ARG DST=/usr/local/bin

# protobuf itself -- protobuf-dev is also needed for certain things (e.g.
# using certain protoc extensions)
RUN apk add --no-cache protobuf protobuf-dev
# plugins
COPY --from=ts-builder /dist/protoc-gen-ts ${DST}/protoc-gen-ts
COPY --from=scala-builder /dist/protoc-gen-scalapb ${DST}/protoc-gen-scala
COPY --from=go-builder /go/bin/protoc-gen-go ${DST}/protoc-gen-go
COPY --from=go-builder /go/bin/protoc-gen-doc ${DST}/protoc-gen-doc

WORKDIR /src
CMD ["/usr/bin/protoc", "--help"]
# ^^^ what we invoke by default
# /usr/local/bin # ls -lh
# total 23M    
# -rwxr-xr-x    1 root     root        3.4M Aug 27 19:15 protoc-gen-doc
# -rwxr-xr-x    1 root     root        1.6M Aug 27 19:15 protoc-gen-go
# -rwxrwxr-x    1 root     root        4.1M Aug 27 19:15 protoc-gen-scala
# -rwxr-xr-x    1 root     root       13.7M Aug 27 19:15 protoc-gen-ts
