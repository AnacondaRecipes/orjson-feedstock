REM Set up rust environment
set CARGO_HOME=%CONDA_PREFIX%\.cargo.win
set CARGO_CONFIG=%CARGO_HOME%\config
set RUSTUP_HOME=%CARGO_HOME%\rustup

FOR /F "delims=" %%i in ('cygpath.exe -u "%SRC_DIR%\rust-nightly-install"') DO set "pfx=%%i"
bash %SRC_DIR%\rust-nightly\install.sh --verbose --prefix=%pfx% --disable-ldconfig --components=rustc,cargo,rust-std-x86_64-pc-windows-msvc
set "PATH=%SRC_DIR%\rust-nightly-install\bin;%PATH%"

maturin build --release --strip --manylinux off --interpreter=%PYTHON%

FOR /F "delims=" %%i IN ('dir /s /b target\wheels\*.whl') DO set orjson_wheel=%%i

%PYTHON% -m pip install --no-deps %orjson_wheel% -vv

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
