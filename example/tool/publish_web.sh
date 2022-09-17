#!/bin/bash
# This script requires lftp (brew install lftp) and op (1Password CLI v2)

flutter clean
# FIXME: --tree-shake-icons is currently broken
flutter build web --no-tree-shake-icons --csp --source-maps --base-href "/faiadashu/"

# shellcheck disable=SC2034
read  -r -n 1 -p "Press Enter to continue with FTP upload:" waitftpinput

ftp_host=$(op read "op://Personal/poegolvkpjeelnf2ep7wygr56m/add more/url")
ftp_user=$(op read "op://Personal/poegolvkpjeelnf2ep7wygr56m/username")
LFTP_PASSWORD=$(op read "op://Personal/poegolvkpjeelnf2ep7wygr56m/password")
export LFTP_PASSWORD

# Upload the release build, plus the source code for the source maps
lftp <<END_SCRIPT
open --user $ftp_user --env-password sftp://$ftp_host
lcd build/web
mirror --parallel=4 --reverse --transfer-all . /faiadashu
lcd ../../..
mirror --parallel=4 --reverse --transfer-all ./lib /
lcd example
mirror --parallel=4 --reverse --transfer-all ./lib /
bye
END_SCRIPT

unset LFTP_PASSWORD
export LFTP_PASSWORD=""
unset ftp_user
unset ftp_host
