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

func Test_execCommand(t *testing.T) {
	tests := []struct {
		name    string
		want    bool
		wantErr bool
	}{
		{
			name:    "test1",
			want:    true,
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := execCommand()
			if (err != nil) != tt.wantErr {
				t.Errorf("execCommand() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if (len(got) != 0) != tt.want {
				t.Errorf("execCommand() = %v, want %v", got, tt.want)
			}
		})
	}
}
