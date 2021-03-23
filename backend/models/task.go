package models

type Task struct {
	Name        string `binding:"required"`
	UserID      string `binding:"required"`
	HouseholdID string `binding:"required"`
	Recurring   bool
}
