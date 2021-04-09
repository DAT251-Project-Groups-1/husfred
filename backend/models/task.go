package models

type Task struct {
	TaskID      string
	Name        string `binding:"required"`
	UserID      string `binding:"required"`
	HouseholdID string `binding:"required"`
	Date        string
	Recurring   bool
	Done        bool
}
