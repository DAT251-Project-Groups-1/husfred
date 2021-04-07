package main

import (
	"context"

	"cloud.google.com/go/firestore"

	"github.com/DAT251-Project-Groups-1/husfred/models"
)

func CreateHousehold(client *firestore.Client) (*firestore.DocumentRef, error) {
	ctx := context.Background()
	household := models.Household{Name: "Test House"}
	ref, _, err := client.Collection("household").Add(ctx, household)
	return ref, err
}

func CreateUser(client *firestore.Client, hh *firestore.DocumentRef) (*firestore.DocumentRef, error) {
	ctx := context.Background()
	user := models.User{Name: "Test User", HouseholdID: hh.ID}
	ref, _, err := client.Collection("user").Add(ctx, user)
	return ref, err
}
