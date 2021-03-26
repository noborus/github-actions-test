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
	type args struct {
		cmdStr []string
	}
	tests := []struct {
		name    string
		args    args
		wantErr bool
	}{
		{
			name: "test1",
			args: args{
				cmdStr: []string{"date"},
			},
			wantErr: false,
		},
		{
			name: "testErr",
			args: args{
				cmdStr: []string{"errorNotFound"},
			},
			wantErr: true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := execCommand(tt.args.cmdStr)
			if (err != nil) != tt.wantErr {
				t.Errorf("execCommand() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
		})
	}
}
