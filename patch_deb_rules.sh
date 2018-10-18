#!/bin/sh
set -e

if [ ! -f $1/debian/changelog ]; then
 echo "Wrong directory specified."
 exit 1
fi

cat debian/changelog $1/debian/changelog > $1/debian/changelog.tmp
mv $1/debian/changelog.tmp $1/debian/changelog
cp debian/patches/* $1/debian/patches/
ls -1 debian/patches/ >> $1/debian/patches/series
patch -d $1 -p1 < debian/rules.patch
