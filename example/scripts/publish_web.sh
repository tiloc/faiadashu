#!/bin/bash
flutter clean
flutter build web --tree-shake-icons --csp
sed -i -e 's/\<base href=\"\/\"\>/\<base href=\"\/faidashu\/\"\>/g' build/web/index.html
pushd build/web
echo "put -r . /faiadashu" | sftp -P 22 $SFTP_HOST
popd

