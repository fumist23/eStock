#!/bin/sh
set -e

# コンテナ起動時に持っているSQLiteのデータベースファイルは、後続処理でrestoreに成功したら削除したいのでrenameしておく
if [ -f ./app/data.db ]; then
  mv ./app/db/estock.db ./app/db/estock.db.bk
fi

# GCSからrestore
litestream restore -if-replica-exists -config ./app/litestream.yaml ./app/db/estock.db

if [ -f ./app/db/estock.db ]; then
  # restoreに成功したら、renameしていたファイルを削除
  echo "---- Restored from Cloud Storage ----"
  rm ./app/db/estock.db.bk
else
  echo "---- Failed to restore from Cloud Storage ----"
  mv ./app/db/estock.db.bk ./app/db/estock.db
fi

# メインプロセスでlitestreamの起動、サブプロセスにGoサーバーの起動を行う。
exec litestream replicate -exec "./app/server" -config ./app/litestream.yaml
