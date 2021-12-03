#!/bin/bash
flutter clean
flutter build web --no-tree-shake-icons --csp
# --source-maps
sed -i -e 's/\<base href=\"\/\"\>/\<base href=\"\/faiabench\/\"\>/g' build/web/index.html

# shellcheck disable=SC2034
read  -r -n 1 -p "Press Enter to continue with FTP upload:" waitftpinput

sftp -P 22 "$SFTP_HOST" <<END
lcd build/web
put -r . /faiabench
bye
END
