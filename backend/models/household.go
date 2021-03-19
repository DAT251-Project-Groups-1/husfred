package models

type Household struct {
	Id   string `json:"id"`
	Name string `json:"name" binding:"required"`
}
