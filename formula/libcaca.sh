package set summary "Convert pixel information into colored ASCII art"
package set webpage "http://caca.zoy.org/wiki/libcaca"
package set src.git "https://github.com/cacalabs/libcaca.git"
package set src.url "https://fossies.org/linux/privat/libcaca-0.99.beta19.tar.gz"
package set src.sum "128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4"
package set license "WTFPL"
package set bsystem "configure"
package set dep.cmd "pkg-config"
package set dep.pkg "imlib2"
package set cdefine "X_DISPLAY_MISSING"
package set ldflags "-lbz2 -lz -lm -lbrotlidec -lbrotlicommon -lpng -lfreetype"

prepare() {
    sed_in_place 's|__BYTE_ORDER|__BYTE_ORDER__|'       caca/dither.c &&
    sed_in_place 's|__BIG_ENDIAN|__ORDER_BIG_ENDIAN__|' caca/dither.c &&
    sed_in_place 's|__BYTE_ORDER|__BYTE_ORDER__|'       examples/font.c &&
    sed_in_place 's|__BIG_ENDIAN|__ORDER_BIG_ENDIAN__|' examples/font.c
}

build() {
    configure \
        --disable-csharp \
        --disable-python \
        --disable-slang \
        --disable-java \
        --disable-ruby \
        --disable-x11 \
        --disable-doc
}
