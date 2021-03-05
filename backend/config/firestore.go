package config

import (
	"cloud.google.com/go/firestore"
	"context"
	firebase "firebase.google.com/go/v4"
	"log"
)

func InitFirestore(app *firebase.App) *firestore.Client {
	firestore, err := app.Firestore(context.Background())
	if err != nil {
		log.Fatalf("error getting Firestore client: %v\n", err)
	}
	return firestore
}
