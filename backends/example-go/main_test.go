// main_test.go
package main

import (
	"testing"
)

func TestMainService(t *testing.T) {
	expected := Response{
		Status:  true,
		Message: "hello world!",
	}

	response := mainService()

	if response != expected {
		t.Errorf("Expected %+v, but got %+v", expected, response)
	}
}

func TestHealthService(t *testing.T) {
	expected := Response{
		Status:  true,
		Message: "Service is healthy",
	}

	response := healthService()

	if response != expected {
		t.Errorf("Expected %+v, but got %+v", expected, response)
	}
}
