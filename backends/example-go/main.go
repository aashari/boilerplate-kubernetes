// main.go
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

// Response structure
type Response struct {
	Status  bool   `json:"status"`
	Message string `json:"message"`
}

// Main service function
func mainService() Response {
	return Response{
		Status:  true,
		Message: "hello world!",
	}
}

// Health service function
func healthService() Response {
	return Response{
		Status:  true,
		Message: "Service is healthy",
	}
}

// Main controller
func mainController(w http.ResponseWriter, r *http.Request) {
	response := mainService()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

// Health controller
func healthController(w http.ResponseWriter, r *http.Request) {
	response := healthService()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func main() {

	// Create router
	http.HandleFunc("/", mainController)
	http.HandleFunc("/health-check", healthController)

	// Start the server
	port := 8080
	fmt.Printf("Server listening on port %d...\n", port)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}
