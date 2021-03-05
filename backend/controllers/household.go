package controllers

import (
	"cloud.google.com/go/firestore"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

type Household struct {
	Name  string
	Users []string
	Tasks []string
}

func NewHousehold(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	household := Household{
		Name:  "Ny",
		Users: nil,
		Tasks: nil,
	}

	_, _, err := client.Collection("household").Add(ctx, household)
	if err != nil {
		log.Printf("An error has occurred: %s", err)
	}

	ctx.JSON(http.StatusOK, household)
}
