#!/bin/sh
set -e

# コンテナ起動時に持っているSQLiteのデータベースファイルは、後続処理でrestoreに成功したら削除したいのでrenameしておく
if [ -f ./database/estock.db ]; then
  mv ./database/estock.db ./database/estock.db.old
fi

# GCSからrestore
litestream restore -if-replica-exists -config ./litestream.yaml ./database/estock.db

if [ -f ./database/estock.db ]; then
  # restoreに成功したら、renameしていたファイルを削除
  echo "---- Restored from Cloud Storage ----"
  rm ./database/estock.db.old
else
  echo "---- Failed to restore from Cloud Storage ----"
  mv ./database/estock.db.old ./database/estock.db
fi

# メインプロセスでGoサーバーの起動、サブプロセスでlitestreamの起動を行う。
exec ./server -exec "litestream replicate -config ./litestream.yaml"
