package main

import (
	"context"
	"fmt"
	"testing"
)

type mytest struct {
	name     string
	response MyResponse
	context  context.Context
	input    interface{}
	error
}

var tests = []mytest{
	{
		name:     "Simple",
		response: MyResponse{Message: fmt.Sprintf("This sucks!!!")},
		context:  context.TODO(),
		input:    nil,
		error:    nil,
	},
}

func TestHandleRequest(t *testing.T) {
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			resp, err := HandleRequest(tt.context, tt.input)
			if err != tt.error {
				t.Errorf("Expected error %s but got %s", tt.error, err)
			}
			if resp != tt.response {
				t.Errorf("Expected response %s but got %s", tt.response, resp)
			}

		})
	}
}
