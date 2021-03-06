package controllers

import (
	"fmt"
	"net/http"
	"strconv"

	"cloud.google.com/go/firestore"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/gin-gonic/gin"
	"google.golang.org/api/iterator"
)

func NewTask(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var task models.Task
	err := ctx.ShouldBindJSON(&task)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Household does not exist"})
		return
	}

	var ref *firestore.DocumentRef
	ref, _, err = client.Collection("household").Doc(task.HouseholdID).Collection("task").Add(ctx, &task)
	if err != nil {
		fmt.Println(err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Collection("task").Doc(ref.ID).Update(ctx, []firestore.Update{
		{
			Path:  "TaskID",
			Value: ref.ID,
		},
	})

	ctx.JSON(http.StatusOK, ref.ID)
}

func GetTasks(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var tasks []models.Task

	var done = false
	var q = ctx.DefaultQuery("done", "false")

	if q == "true" {
		done = true
	}
	from, fromErr := strconv.Atoi(ctx.DefaultQuery("from", "unknown"))
	to, toErr := strconv.Atoi(ctx.DefaultQuery("to", "unknown"))

	var iter *firestore.DocumentIterator
	if fromErr == nil && toErr == nil {
		iter = client.Collection("household").Doc(ctx.Param("householdID")).Collection("task").Where("Done", "==", done).OrderBy("Date", firestore.Asc).StartAt(from).EndAt(to).Documents(ctx)
	} else {
		iter = client.Collection("household").Doc(ctx.Param("householdID")).Collection("task").Where("Done", "==", done).Documents(ctx)
	}
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			fmt.Println(err.Error())
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		var task models.Task
		if err := doc.DataTo(&task); err != nil {
			fmt.Println(err.Error())
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		tasks = append(tasks, task)
	}
	ctx.JSON(http.StatusOK, tasks)
}

func FinishTask(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var task models.Task
	err := ctx.ShouldBindJSON(&task)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("user").Doc(task.UserID).Update(ctx, []firestore.Update{
		{
			Path:  "Points",
			Value: firestore.Increment(task.Points),
		},
	})
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "User does not exist"})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Household does not exist"})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Collection("task").Doc(task.TaskID).Update(ctx, []firestore.Update{
		{
			Path:  "Done",
			Value: true,
		},
	})
	if err != nil {
		fmt.Println(err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, task.TaskID)
}

func VoteTask(ctx *gin.Context) {
	client := ctx.MustGet("firestore").(*firestore.Client)

	var task models.Task
	err := ctx.ShouldBindJSON(&task)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Get(ctx)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Household does not exist"})
		return
	}

	_, err = client.Collection("household").Doc(task.HouseholdID).Collection("task").Doc(task.TaskID).Update(ctx, []firestore.Update{
		{
			Path:  "Votes",
			Value: task.Votes,
		},
	})
	if err != nil {
		fmt.Println(err.Error())
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusOK, task.TaskID)
}
