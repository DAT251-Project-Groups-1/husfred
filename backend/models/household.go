package models

type Household struct {
	Name string `json:"name" binding:"required"`
}
