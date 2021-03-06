package set summary "Implementation of the DNS protocols"
package set webpage "https://www.isc.org/downloads/bind"
package set src.url "https://downloads.isc.org/isc/bind9/9.16.8/bind-9.16.8.tar.xz"
package set src.sum "9e9b9c563692be86ec41f670f6b70e26c14e72445c742d7b5eb4db7d2b5e8d31"
package set license "MPL-2.0"
package set bsystem "configure"
package set dep.cmd "base64 patch pkg-config"
package set dep.pkg "zlib json-c libxml2 libidn2 libuv openssl"

# checking for Thread-Local Storage using __thread... configure: error: Thread Local Storage support required, update your toolchain to build BIND 9

prepare() {
#--- configure	2020-10-13 16:41:40.000000000 +0800
#+++ configure2	2020-11-13 16:57:48.000000000 +0800
#@@ -22048,10 +22048,7 @@
# 
# LDFLAGS="-Wl,--wrap,exit"
# if test "$cross_compiling" = yes; then :
#-  { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
#-$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
#-as_fn_error $? "cannot run test program while cross compiling
#-See \`config.log' for more details" "$LINENO" 5; }
#+    :
# else
#   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
# /* end confdefs.h.  */

    echo "LS0tIGNvbmZpZ3VyZQkyMDIwLTEwLTEzIDE2OjQxOjQwLjAwMDAwMDAwMCArMDgwMAorKysgY29uZmlndXJlMgkyMDIwLTExLTEzIDE2OjU3OjQ4LjAwMDAwMDAwMCArMDgwMApAQCAtMjIwNDgsMTAgKzIyMDQ4LDcgQEAKIAogTERGTEFHUz0iLVdsLC0td3JhcCxleGl0IgogaWYgdGVzdCAiJGNyb3NzX2NvbXBpbGluZyIgPSB5ZXM7IHRoZW4gOgotICB7IHsgJGFzX2VjaG8gIiRhc19tZToke2FzX2xpbmVuby0kTElORU5PfTogZXJyb3I6IGluIFxgJGFjX3B3ZCc6IiA+JjUKLSRhc19lY2hvICIkYXNfbWU6IGVycm9yOiBpbiBcYCRhY19wd2QnOiIgPiYyO30KLWFzX2ZuX2Vycm9yICQ/ICJjYW5ub3QgcnVuIHRlc3QgcHJvZ3JhbSB3aGlsZSBjcm9zcyBjb21waWxpbmcKLVNlZSBcYGNvbmZpZy5sb2cnIGZvciBtb3JlIGRldGFpbHMiICIkTElORU5PIiA1OyB9CisgICAgOgogZWxzZQogICBjYXQgY29uZmRlZnMuaCAtIDw8X0FDRU9GID5jb25mdGVzdC4kYWNfZXh0CiAvKiBlbmQgY29uZmRlZnMuaC4gICovCg==" | base64 -d | patch
}

build() {
    configure \
        --disable-linux-caps \
        --without-python \
        --without-gssapi \
        --without-readline \
        --with-zlib \
        --with-json-c \
        --with-libxml2 \
        --with-libidn2=yes \
        --with-openssl="$openssl_INSTALL_DIR" \
        BUILD_CC="$CC_FOR_BUILD"
}
