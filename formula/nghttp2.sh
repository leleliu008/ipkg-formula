package set summary "HTTP/2 C Library"
package set webpage "https://nghttp2.org"
package set src.url "https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.xz"
package set src.sum "abc25b8dc601f5b3fefe084ce50fcbdc63e3385621bee0cbfa7b57f9ec3e67c2"
package set license "MIT"
package set bsystem "configure"
package set dep.pkg "libevent libev openssl jansson libxml2 c-ares cunit"

# ld: targeted OS package set version does not support use of thread local variables in __ZN5shrpx10log_configEv for architecture x86_64
# https://stackoverflow.com/questions/52282646/build-error-targeted-os-version-does-not-support-use-of-thread-local-variables

build() {
    configure \
        --enable-threads \
        --enable-app \
        --enable-examples \
        --enable-hpack-tools \
        --disable-asio-lib \
        --disable-python-bindings \
        --disable-lib-only \
        --disable-werror \
        --disable-assert \
        --without-systemd \
        --without-jemalloc \
        --with-libxml2 \
        ZLIB_CFLAGS='-lz' \
        ZLIB_LIBS='-lz'
}
