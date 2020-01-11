package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/mattn/go-sqlite3"
)

func hello() string {
	db, err := sql.Open("sqlite3", "")
	if err != nil {
		log.Fatal(err)
	}
	rows, err := db.Query("SELECT 'Hello, World!'")
	if err != nil {
		log.Fatal(err)
	}
	var r string
	for rows.Next() {
		err = rows.Scan(&r)
		if err != nil {
			log.Fatal(err)
		}
	}
	err = db.Close()
	if err != nil {
		log.Fatal(err)
	}
	return r
}

func main() {
	fmt.Println(hello())
}
