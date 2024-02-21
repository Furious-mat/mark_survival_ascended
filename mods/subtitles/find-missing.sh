#!/usr/bin/env bash


###############################################################################
#                                                                             #
#  Subtitles ‘find-missing.sh’ — Lists sounds without descriptions.           #
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


function filter-missing()
{
    while read -r path; do
        if ! grep -F -q "subtitles.register_description('${path##*/}'," "$(dirname "$0")/descriptions.lua"; then
            echo "$path"
        fi
    done
}


dirs=("$@")
if [[ "${#dirs[@]}" == 0 ]]; then
    echo 'Checking installed games and mods.'
    dirs=(~/.minetest/{mods,games})
fi


find -L "${dirs[@]}" -name '*.ogg' \
    | sed -r 's!(.+)/(\w+)\..*!\1/\2!; t; d' \
    | sort \
    | uniq \
    | filter-missing \
    | sed -r 's!(.*)/(\w+)!\x1B[2m\1/\x1B[0;1m\2\x1B[m!' \
    | cat -n
