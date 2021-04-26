package controllers

import (
	"fmt"
	"net/http"

	"firebase.google.com/go/v4/auth"
	"google.golang.org/api/iterator"

	"cloud.google.com/go/firestore"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/gin-gonic/gin"
)

func NewUser(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)
	userRecord := ctx.MustGet("user").(*auth.UserRecord)

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

	_, err = client.Collection("user").Doc(userRecord.UID).Set(ctx, &user)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, userRecord.UID)
}

func GetUsersInHousehold(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)
	householdID := ctx.Param("id")

	var users []models.User
	iter := client.Collection("user").Where("HouseholdID", "==", householdID).OrderBy("Points", firestore.Desc).Documents(ctx)

	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		fmt.Println(doc.Data())
		var user models.User
		if err := doc.DataTo(&user); err != nil {
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		user.UserID = doc.Ref.ID
		users = append(users, user)
	}
	ctx.JSON(http.StatusOK, users)
}
