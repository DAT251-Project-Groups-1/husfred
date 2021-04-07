package models

// User represents a user of the application
type User struct {
	Name        string `binding:"required"`
	HouseholdID string `binding:"required"`
	Points      int
}