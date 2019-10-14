#!/bin/bash
set -eo pipefail

IMAGE=openlaw/protocore
BASE=$(dirname "$0")
EXPECT=${BASE}/expect
DEST=${BASE}/build

# clear and prepare the output folder in advance
rm -rf "${DEST}"
mkdir -p "${DEST}/go" "${DEST}/js" "${DEST}/scala"

# generate files
docker run --rm \
    -v "$(pwd)":/src \
    ${IMAGE} protoc \
        --go_out=plugins=grpc:"${DEST}/go" \
        --js_out=import_style=commonjs,binary:"${DEST}/js" \
        --ts_out="${DEST}/js" \
        --scala_out="${DEST}/scala" \
        --doc_out="${DEST}" --doc_opt=markdown,docs.md \
        "${BASE}/addressbook.proto"

# compare generated files with expected
diff --brief --recursive --no-ignore-file-name-case --new-file \
    "${EXPECT}/" "${DEST}/"
