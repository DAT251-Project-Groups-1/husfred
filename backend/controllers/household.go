package controllers

import (
	"cloud.google.com/go/firestore"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func NewHousehold(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var household models.Household
	err := ctx.ShouldBind(&household)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, _, err = client.Collection("household").Add(ctx, &household)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, &household)
}
