package main

import (
	"fmt"
	"net/http"
	"net/url"
	"testing"
)

var (
	u = url.URL{
		Host:   "localhost:9000",
		Scheme: "http",
		Path:   "/2015-03-31/functions/function/invocations",
	}
)

func TestDocker(t *testing.T) {
	resp, err := http.Post(u.String(), "application/json", nil)

	fmt.Println("test")

	if err != nil {
		t.Errorf("Error from request: %s\n", err)
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		t.Errorf("Unexpected response code: %d\n", resp.StatusCode)
	}
}
