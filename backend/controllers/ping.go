package controllers

import (
	"time"

	"github.com/gin-gonic/gin"
)

func Ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message":   "pong",
		"timestamp": time.Now().Format("2006.01.02 15:04:05"),
	})
}
