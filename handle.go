package main

import (
	"context"
	"fmt"
)

type MyResponse struct {
	Message string `json:"Answer:"`
}

func HandleRequest(ctx context.Context, name interface{}) (MyResponse, error) {
	return MyResponse{Message: fmt.Sprintf("This sucks!!!")}, nil
}
