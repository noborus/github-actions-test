package main

import (
	"testing"

	_ "github.com/mattn/go-sqlite3"
)

func Test_hello(t *testing.T) {
	tests := []struct {
		name string
		want string
	}{
		{
			name: "hello",
			want: "Hello, World!",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := hello(); got != tt.want {
				t.Errorf("hello() = %v, want %v", got, tt.want)
			}
		})
	}
}
