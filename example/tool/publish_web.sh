#!/bin/bash
flutter clean
# FIXME: --tree-shake-icons is currently broken
flutter build web --no-tree-shake-icons --csp --source-maps --base-href "/faiadashu/"

# shellcheck disable=SC2034
read  -r -n 1 -p "Press Enter to continue with FTP upload:" waitftpinput

# Upload the release build, plus the source code for the source maps
sftp -P 22 "$SFTP_HOST" <<END
lcd build/web
put -r . /faiadashu
lcd ../../..
put -r ./lib /
lcd example
put -r ./lib /
bye
END

