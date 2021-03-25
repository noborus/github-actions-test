package main

import (
	"database/sql"
	"fmt"
	"log"
	"os/exec"

	_ "github.com/mattn/go-sqlite3"
)

func execCommand() ([]byte, error) {
	cmd := exec.Command("date")
	return cmd.Output()
}

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
	v, err := execCommand()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(v))
	fmt.Println(hello())
}
