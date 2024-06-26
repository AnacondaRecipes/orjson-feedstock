#!/bin/bash

set -ex

# Set up rust environment
export CARGO_HOME=${CONDA_PREFIX}/.cargo.$(uname)
export CARGO_CONFIG=${CARGO_HOME}/config
export RUSTUP_HOME=${CARGO_HOME}/rustup

maturin build --release --strip --manylinux off --interpreter="${PYTHON}"

"${PYTHON}" -m pip install $SRC_DIR/target/wheels/orjson*.whl --no-deps -vv --no-build-isolation

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
