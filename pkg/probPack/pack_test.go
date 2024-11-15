package probpack

import (
	"defaultGoProject/internal/logger"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"
)

func init() {
	logger.InitLogger()
}

// go test .
func TestAdd(t *testing.T) {
	type args struct {
		a int
		b int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{
			name: "case_1",
			args: args{
				a: 1,
				b: 1,
			},
			want: 2,
		}, {
			name: "case_2",
			args: args{
				a: 2,
				b: 1,
			},
			want: 3,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Add(tt.args.a, tt.args.b); got != tt.want {
				t.Errorf("Add() = %v, want %v", got, tt.want)
			}
		})
	}
}

// testify .
func TestAdd2(t *testing.T) {
	arg1 := 1
	arg2 := 1
	expected := 2

	actual := Add(arg1, arg2)
	assert.Equal(t, expected, actual)
}

// bench .
func BenchmarkAdd2(b *testing.B) {
	p, j := 0, 0
	for i := 0; i < b.N; i++ {
		p += j
	}
}

func BenchmarkAdd(b *testing.B) {
	for i := 0; i < b.N; i++ {
		if Add(1, 1) != 2 {
			log.Fatal("[oops]")
		}
	}
}
