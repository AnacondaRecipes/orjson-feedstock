REM Set up rust environment
set CARGO_HOME=%CONDA_PREFIX%\.cargo.win
set CARGO_CONFIG=%CARGO_HOME%\config
set RUSTUP_HOME=%CARGO_HOME%\rustup

maturin build --release --strip --manylinux off --interpreter=%PYTHON%

FOR /F "delims=" %%i IN ('dir /s /b target\wheels\*.whl') DO set orjson_wheel=%%i

%PYTHON% -m pip install --no-deps %orjson_wheel% -vv --no-build-isolation

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
