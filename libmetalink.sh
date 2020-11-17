summary="C library to parse Metalink XML files"
homepage="https://launchpad.net/libmetalink"
url="https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz"
sha256="86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a"
dependencies="expat"

build() {
    configure \
        --with-libexpat=yes \
        --with-libxml2=no \
        --with-xml-prefix="$expat_INSTALL_DIR" \
        --disable-xmltest \
        ac_cv_func_malloc_0_nonnull=yes \
        ac_cv_func_realloc_0_nonnull=yes
}