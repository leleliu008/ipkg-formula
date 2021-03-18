summary "Terminal multiplexer"
webpage "https://tmux.github.io"
src_url "https://github.com/tmux/tmux/releases/download/3.1c/tmux-3.1c.tar.gz"
src_sum "918f7220447bef33a1902d4faff05317afd9db4ae1c9971bef5c787ac6c88386"
license "ISC"
bsystem "configure"
depends "ncurses libevent utf8proc"

build() {
    # https://stackoverflow.com/questions/34229900/error-unknown-type-name-u-char-in-osx-10-11-2
    export CPPFLAGS="$CPPFLAGS -D_DARWIN_C_SOURCE"
    configure \
        --enable-utf8proc \
        ac_cv_search_utf8proc_charwidth=yes
}