#! /bin/sh

cd `dirname "$0"`
CURDIR=`pwd`

echo "Checking libmaxminddb ..."

VERSION=1.3.2
URL=https://github.com/maxmind/libmaxminddb/archive/$VERSION.tar.gz

if [ ! -f "libmaxminddb/src/.libs/libmaxminddb.a" ] ; then
    echo -e "\033[38;5;148mDownloading libmaxminddb version $VERSION and building, it will take several minutes ...\033[39m"

    wget  --no-check-certificate  -O mmdb.tgz   $URL
    tar xf mmdb.tgz
    mv libmaxminddb-$VERSION ../libmaxminddb
    cd ../libmaxminddb
    
    ./bootstrap 
    ./configure --disable-tests
    make

    if [ ! -f "src/.libs/libmaxminddb.a" ] ; then
        echo -e "\033[38;5;148mError: failed to make libmaxminddb library.\033[39m"
        exit 1
    else
        echo -e "\033[38;5;148mGood, libmaxminddb made.\033[39m"
        cd ..
        mv libmaxminddb $CURDIR/
        exit 0
    fi
else
    echo -e "\033[38;5;148mlibmaxminddb library exist.\033[39m"
    exit 0
fi
