#!/usr/bin/env bash


###############################################################################
#                                                                             #
#  Subtitles build script                                                     #
#  Written in 2022 by Silver Sandstone <@SilverSandstone@craftodon.social>    #
#                                                                             #
#  To the extent possible under law, the author has dedicated all copyright   #
#  and related and neighbouring rights to this software to the public         #
#  domain worldwide. This software is distributed without any warranty.       #
#                                                                             #
#  You should have received a copy of the CC0 Public Domain Dedication        #
#  along with this software. If not, see                                      #
#  <https://creativecommons.org/publicdomain/zero/1.0/>.                      #
#                                                                             #
###############################################################################


set -eu
cd "$(dirname "$0")"


function status()
{
    printf '\n\e[1m%s\e[m\n' "$*"
}


status 'Generating documentation...'
ldoc './' --dir 'doc/' --title 'Subtitles API Reference'


status 'Generating localisation file...'
mkdir -p 'locale/'
xgettext --from-code='UTF-8' --escape -k'S' --language='lua' -o 'locale/en.pot' --omit-header ./*.lua


status 'Creating distribution...'
archive='subtitles.zip'
[[ -e "$archive" ]] && rm "$archive"
zip -r "$archive" -- \
    *.lua \
    mod.conf \
    settingtypes.txt \
    build.sh \
    find-missing.sh \
    README.md \
    CHANGELOG.md \
    LICENSE.md \
    screenshot.png \
    textures/ \
    doc/


status 'Build complete.'
grep '^subtitles\.VERSION = ' init.lua
