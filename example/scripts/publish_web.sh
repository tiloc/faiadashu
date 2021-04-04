#!/bin/bash
flutter build web
sed 's/\<base href=\"\/\"\>/\<base href=\"\/faidashu\/\"\>/g' build/web/index.html > build/web/index.html
pushd build/web
echo "put -r . /faiadashu" | sftp -P 22 $SFTP_HOST
popd

