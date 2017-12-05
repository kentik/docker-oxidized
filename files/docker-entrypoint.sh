#!/bin/bash
set -eo pipefail
shopt -s nullglob
set -x

chown -R oxidized:oxidized /home/oxidized

exec "/usr/bin/supervisord"
