package set summary "Tool Command Language"
package set webpage "https://www.tcl-lang.org"
package set version "8.6.10"
package set src.url "https://downloads.sourceforge.net/project/tcl/Tcl/${PACKAGE_VERSION}/tcl${PACKAGE_VERSION}-src.tar.gz"
package set src.sum "5196dbf6638e3df8d5c87b5815c8c2b758496eb6f0e41446596c9a4e638d87ed"
package set license "TCL"

prepare() {
    cd unix &&
    SOURCE_DIR="$PWD" &&
    sed_in_place 's/test "`uname -s`" = "Darwin"/false/g' configure
}

build() {
    unset EXTRA_CONFIGURE_FLAGS
    
    case $TARGET_OS_ARCH in
        *64*)
            EXTRA_CONFIGURE_FLAGS="$EXTRA_CONFIGURE_FLAGS --enable-64bit";;
        *)  EXTRA_CONFIGURE_FLAGS="$EXTRA_CONFIGURE_FLAGS --disable-64bit"
    esac
        
    export CPPFLAGS="$CPPFLAGS -DMAC_OSX_TCL=1"

    configure \
        --enable-langinfo \
        --enable-dtrace \
        --enable-zipfs \
        --disable-load \
        --disable-dll-unloading \
        --enable-threads \
        --disable-symbols \
        --enable-corefoundation \
        --enable-framework \
        --with-tzdata \
        $EXTRA_CONFIGURE_FLAGS \
        tcl_cv_sys_version=Darwin
}
