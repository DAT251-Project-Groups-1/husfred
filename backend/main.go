package main

import (
	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/controllers"
	"github.com/gin-gonic/gin"
)

func main() {
	firebase := config.InitFirebase()
	auth := config.InitAuth(firebase)
	firestore := config.InitFirestore(firebase)

	router := gin.Default()
	router.Use(func(c *gin.Context) {
		c.Set("firestore", firestore)
		c.Set("auth", auth)
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
