package main

import (
	"github.com/DAT251-Project-Groups-1/husfred/controllers"
	"github.com/DAT251-Project-Groups-1/husfred/services"
	"github.com/gin-gonic/gin"
)

func main() {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)

	router := gin.Default()

	// Enable cors support
	//router.Use(middleware.Cors)

	router.Use(func(ctx *gin.Context) {
		ctx.Set("firestore", firestore)
		ctx.Set("auth", auth)
	})
	router.GET("/ping", Ping)

	household := router.Group("/household")
	household.POST("/new", controllers.NewHousehold)

    router.Run()
}

func Ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}
