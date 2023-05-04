#!/bin/sh
set -e


echo "---- script started!! ----"

# コンテナ起動時に持っているSQLiteのデータベースファイルは、後続処理でrestoreに成功したら削除したいのでrenameしておく
if [ -f ./db/estock.db ]; then
  mv ./db/estock.db ./db/estock.db.bk
fi

# GCSからrestore
litestream restore -if-replica-exists -config ./litestream.yaml ./db/estock.db

if [ -f ./db/estock.db ]; then
  # restoreに成功したら、renameしていたファイルを削除
  echo "---- Restored from Cloud Storage ----"
  rm ./db/estock.db.bk
else
  echo "---- Failed to restore from Cloud Storage ----"
  mv ./db/estock.db.bk ./db/estock.db
fi

# メインプロセスでlitestreamの起動、サブプロセスにGoサーバーの起動を行う。
exec litestream replicate -exec "./server" -config ./litestream.yaml
