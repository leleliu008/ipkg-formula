package set summary "HTTP(S) server and reverse proxy, and IMAP/POP3 proxy server"
package set webpage "https://nginx.org"
package set src.url "https://nginx.org/download/nginx-1.19.1.tar.gz"
package set src.sum "a004776c64ed3c5c7bc9b6116ba99efab3265e6b81d49a57ca4471ff90655492"
package set bsystem "make"
package set dep.pkg "openssl pcre"

trace_configure() {
    for item in $(ls $1)
    do
        if [ -f "$1/$item" ] ; then
            if [ "$XTRACE" = 'true' ] ; then
                sed_in_place '1i set -x' "$1/$item"
            fi
            sed_in_place 's/ngx_feature_run=yes/ngx_feature_run=no/g' "$1/$item"
        elif [ -d "$1/$item" ] ; then
            trace_configure "$1/$item"
        fi
    done
}

prepare() {
    trace_configure auto
    if [ "$XTRACE" = 'true' ] ; then
        sed_in_place '1i set -x' configure
    fi
    sed_in_place 's/ngx_test="$CC/ngx_test="$CC $NGX_CC_OPT/' auto/include &&
    sed_in_place '/ngx_test=/i CC_TEST_FLAGS="$NGX_CC_OPT"' auto/feature &&
    sed_in_place '/ngx_test=/i CC_TEST_FLAGS="$NGX_CC_OPT"' auto/endianness &&
    sed_in_place '/ngx_test=/i CC_TEST_FLAGS="$NGX_CC_OPT"' auto/types/typedef &&
    sed_in_place '/ngx_test=/i CC_TEST_FLAGS="$NGX_CC_OPT"' auto/types/sizeof &&
    sed_in_place '/ngx_test=/i CC_TEST_FLAGS="$NGX_CC_OPT"' auto/types/uintptr_t
}

package set binsrcd true

build() {
    export NGX_SYSTEM=Darwin
    export NGX_RELEASE=unkown
    export NGX_MACHINE=$TARGET_OS_ARCH

    case $TARGET_OS_ARCH in
        armv*|x86)
            sed_in_place 's/ngx_size=`$NGX_AUTOTEST`/ngx_size=4/' auto/types/sizeof ;;
        arm64*|x86_64)
            sed_in_place 's/ngx_size=`$NGX_AUTOTEST`/ngx_size=8/' auto/types/sizeof ;;
    esac
    
    [ -f Makefile ] && makew clean
    
    run ./configure \
        --prefix="$ABI_INSTALL_DIR" \
        --crossbuild=Darwin:unkown:$TARGET_OS_ARCH \
        --with-cc="$CC" \
        --with-cc-opt="'$CFLAGS $CPPFLAGS'" \
        --with-ld-opt="'$LDFLAGS -lcrypto'" \
        --with-pcre &&
    write_NGX_SYS_NERR &&
    makew install
}

write_NGX_SYS_NERR() {
    cat >> objs/ngx_auto_config.h <<EOF
#ifndef NGX_SYS_NERR
#define NGX_SYS_NERR  107
#endif
EOF
}
