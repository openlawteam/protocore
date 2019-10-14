# protocore

Everything needed to generate protobuf files for common languages used across
OpenLaw, with zero dependencies.

1. Includes the default `protoc` protocol buffer code generation tool, along
   with dev extensions.

2. Adds plugins for support for the following language generation:
   - [Scala](https://scalapb.github.io/scalapbc.html)
   - [Go](https://github.com/golang/protobuf/)
   - [TypeScript](https://github.com/improbable-eng/ts-protoc-gen)
   - [Documentation](https://github.com/pseudomuto/protoc-gen-doc)

**All plugins are compiled into native binaries and compressed via UPX. As a
result, this image is relatively quite small (50mb uncompressed), and does not
require any runtime dependencies such as the JVM or NodeJS.**

## Usage

_Typically you won't be invoking this directly unless you need it -- it is
primarily intended for reproducible builds across CI and Makefiles._

Generally, you can just treat `openlaw/protocore` as an environment that has the
`protoc` and all the plugins tools setup and in the path. Protocore uses `/src`
as it's default WORKDIR, so if you volume mount the directory you want to work
on to there, you can use it to generate files in your local filesystem.

### Simple command line usage

Create Scala bindings for `helloworld.proto` in your current working directory.

```shell
$ docker run --rm -it -v "$(pwd)":/src openlaw/protocore \
    protoc --scala_out=. helloworld.proto
```

### In a script or makefile

Here's a more sophisticated example that simultaneously generates gRPC
compatible bindings for Go, Javascript with TypeScript definitions, and Scala --
as well as using docgen to produce a README.md documenting the spec.

```bash
docker run --rm -it \
    -v "$(pwd)":/src \
    openlaw/protocore protoc \
        --go_out=plugins=grpc:. \
        --js_out=import_style=commonjs,binary:. \
        --ts_out=. \
        --scala_out=. \
        --doc_out=. --doc_opt=markdown,README.md \
        helloworld.proto
```

You can see a more full version of this (with output subdirectories and a
Makefile) in the [`example/`](example/) directory.

### Aliasing

If you work directly with protocore from the command line often (doubtful, but
it's possible!), you may wish to make an alias such as:

    alias protocore='docker run --rm -it -v "$(pwd)":/src openlaw/protocore'

This enables you to simply prepend `protocore` to any protoc command you may
with to run while working with your local filesystem, and have it work in the
controlled container environment without requiring you to configure stuffs
locally:

```shell
$ protocore protoc --scala_out=. helloworld.proto
```

## Other handy tools for working with protobuf

VS Code editor support (syntax highlighting, linting):
https://marketplace.visualstudio.com/items?itemName=zxh404.vscode-proto3

## Alternatives

See also: https://github.com/uber/prototool
