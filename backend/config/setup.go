package config

import (
	"cloud.google.com/go/firestore"
	"firebase.google.com/go/v4/auth"
	"github.com/DAT251-Project-Groups-1/husfred/controllers"
	"github.com/DAT251-Project-Groups-1/husfred/middleware"
	"github.com/gin-gonic/gin"
)

func SetupRouter(auth *auth.Client, firestore *firestore.Client) *gin.Engine {
	router := gin.Default()
	// Enable cors support
	router.Use(middleware.Cors)

	router.Use(func(ctx *gin.Context) {
		ctx.Set("firestore", firestore)
		ctx.Set("auth", auth)
	})

	household := router.Group("/household")
	household.POST("/new", controllers.NewHousehold)
	household.GET("/:id", controllers.GetHousehold)

	user := router.Group("/user")
	user.Use(middleware.Auth)
	user.POST("/new", controllers.NewUser)
	user.GET("/household/:id", controllers.GetUsersInHousehold)
	user.DELETE("", controllers.DeleteUser)

	task := router.Group("/task")
	task.POST("/new", controllers.NewTask)
	task.POST("/finish", controllers.FinishTask)
	task.GET("/:householdID", controllers.GetTasks)
	task.PUT("/vote", controllers.VoteTask)

	return router
}
