package cmd

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3"
)

func initDB(ctx context.Context) (func(), error) {
	db, err := sql.Open("sqlite3", "./database/estock.db")
	if err != nil {
		return nil, err
	}
	cleanup := func() {
		db.Close()
	}

	if err := db.PingContext(ctx); err != nil {
		return cleanup, err
	}

	sqlStmt := `
		create table if not exists users (id integer not null primary key, name text);
		delete from users;
	`
	_, err = db.ExecContext(ctx, sqlStmt)
	if err != nil {
		log.Printf("%q: %s\n", err, sqlStmt)
		return cleanup, err
	}

	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return cleanup, err
	}

	stmt, err := tx.PrepareContext(ctx, "insert into users(id, name) values(?, ?)")
	if err != nil {
		return cleanup, err
	}
	defer stmt.Close()

	for i := 0; i < 10; i++ {
		_, err = stmt.ExecContext(ctx, i, fmt.Sprintf("user%d", i))
		if err != nil {
			return cleanup, err
		}
	}
	err = tx.Commit()
	if err != nil {
		return cleanup, err
	}

	rows, err := db.QueryContext(ctx, "select id, name from users")
	if err != nil {
		return cleanup, err
	}
	defer rows.Close()

	for rows.Next() {
		var (
			id   int
			name string
		)
		err := rows.Scan(&id, &name)
		if err != nil {
			return cleanup, err
		}
		log.Printf("id: %d, name: %s", id, name)
	}
	err = rows.Err()
	if err != nil {
		return cleanup, err
	}

	return cleanup, nil
}
