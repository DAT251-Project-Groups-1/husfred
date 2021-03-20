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

	user := router.Group("/user")
	user.POST("/new", controllers.NewUser)

	return router
}
