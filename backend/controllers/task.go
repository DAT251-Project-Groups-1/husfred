package controllers

import (
	"fmt"
	"net/http"

	"cloud.google.com/go/firestore"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/gin-gonic/gin"
)

func NewTask(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var task models.Task
	err := ctx.ShouldBindJSON(&task)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("user").Doc(task.UserID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "User does not exist"})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Household does not exist"})
		return
	}

	var ref *firestore.DocumentRef
	ref, _, err = client.Collection("task").Add(ctx, &task)
	if err != nil {
		fmt.Println(err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, ref.ID)
}
