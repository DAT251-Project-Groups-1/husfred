package controllers

import (
	"net/http"

	"cloud.google.com/go/firestore"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/gin-gonic/gin"
)

func NewUser(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var user models.User
	err := ctx.ShouldBindJSON(&user)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("household").Doc(user.HouseholdID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Household does not exist"})
		return
	}

	ref, _, err := client.Collection("user").Add(ctx, &user)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, ref.ID)
}

func GetUsersInHousehold(ctx *gin.Context) {

}
