package models

type Task struct {
	TaskID      string
	Name        string `binding:"required"`
	UserID      string
	HouseholdID string `binding:"required"`
	Date        int `binding:"required"`
	Points		int `binding:"required"`
	Recurring   bool
	Done        bool
	Votes       []string
}
