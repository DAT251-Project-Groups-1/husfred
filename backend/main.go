package main

import (
	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/services"
)

func main() {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)

	router := config.SetupRouter(auth, firestore)
	router.Run()
}
