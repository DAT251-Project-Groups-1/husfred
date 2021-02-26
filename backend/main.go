package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/ping", Ping)
    r.Run()
}

func Ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}
