#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE=$DIR/..
SRC=$BASE
TMP=$SRC/build/tmp
OUTPUT=${1:-$BASE/build/epub/setalo-budapest-2019.epub}

cat $SRC/index.md  \
  | gawk '{ RS = "\f"; a=gensub(/(\([^\.\]]*\.md)#/, "(#", "gmi", $0); print a}' > $TMP/index.md

FILES=(\
        $TMP/index.md  \
        $SRC/001-fovarosi-onkormanyzas-szervezeti-kerdesei.md \
        $SRC/002-varosszerkezet.md \
        $SRC/003-varosarculat-es-oroksegvedelem.md \
        $SRC/004-kozlekedes.md \
        $SRC/005-varosi-kornyezet-es-kornyezetvedelem.md \
        $SRC/006-zold-infrastruktura.md \
        $SRC/007-a-fovaros-ejszakai-gazdasaga-ez-nappali-kulturaja.md \
        $SRC/008-lakhatas-es-hajlektalansag.md \
        $SRC/009-szocialis-ellatasok-es-egeszsegugy.md \
        $SRC/010-oktatasugy-ifjusagpolitika.md \
        $SRC/011-vallalkozasok-magangazdasag.md \
        $DIR/meta.yaml
     )

echo "${FILES[@]}" | xargs pandoc --epub-stylesheet=$DIR/style.css -s -o $OUTPUT
