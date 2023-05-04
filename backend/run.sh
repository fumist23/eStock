#!/bin/sh
set -e


echo "---- script started!! ----"

# コンテナ起動時に持っているSQLiteのデータベースファイルは、後続処理でrestoreに成功したら削除したいのでrenameしておく
if [ -f ./estock.db ]; then
  mv ./estock.db ./estock.db.bk
fi

# GCSからrestore
litestream restore -if-replica-exists -config ./litestream.yaml ./estock.db

if [ -f ./estock.db ]; then
  # restoreに成功したら、renameしていたファイルを削除
  echo "---- Restored from Cloud Storage ----"
  rm ./estock.db.bk
else
  echo "---- Failed to restore from Cloud Storage ----"
  mv ./estock.db.bk ./estock.db
fi

# メインプロセスでlitestreamの起動、サブプロセスにGoサーバーの起動を行う。
exec litestream replicate -exec "./server" -config ./litestream.yaml
