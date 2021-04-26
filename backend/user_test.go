package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"testing"

	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/go-playground/assert/v2"
)

func TestUserRegistrationShouldFailIfHouseholdDoesntExist(t *testing.T) {
	_, _, _, router, w := InitTesting()

	postBody, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: "Nonexisting"})
	requestBody := bytes.NewBuffer(postBody)
	req, _ := http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}

func TestUserRegistrationShouldPassIfHouseholdExists(t *testing.T) {
	ctx := context.Background()
	_, auth, firestore, router, w := InitTesting()

	household, err := CreateHousehold(firestore)
	if err != nil {
		t.Error("Failed creation of household")
		return
	}

	user, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: household.ID})
	requestBody := bytes.NewBuffer(user)
	req, _ := http.NewRequest("POST", "/user/new", requestBody)
	token := CreateFirebaseAuthUser(auth, "testUser")
	bearer := "Bearer " + token
	req.Header.Set("Authorization", bearer)
	router.ServeHTTP(w, req)

	var userId string
	err = json.Unmarshal(w.Body.Bytes(), &userId)
	snapshot, err := firestore.Collection("user").Doc(userId).Get(ctx)
	if err != nil {
		fmt.Println(err)
	}
	assert.IsEqual(snapshot.Exists(), true)
}

func TestGetUserFromHouseholdGetsUsers(t *testing.T) {
	_, auth, firestore, router, w := InitTesting()

	household, err := CreateHousehold(firestore)
	if err != nil {
		t.Error("Failed creation of household")
		return
	}

	_, err = CreateUser(firestore, household)
	if err != nil {
		t.Error("Failed creation of user", err)
		return
	}

	url := fmt.Sprintf("/user/household/%s", household.ID)
	req, _ := http.NewRequest("GET", url, nil)
	token := CreateFirebaseAuthUser(auth, "testUser")
	bearer := "Bearer " + token
	req.Header.Set("Authorization", bearer)
	router.ServeHTTP(w, req)

	var users []models.User

	_ = json.Unmarshal(w.Body.Bytes(), &users)

	assert.Equal(t, 1, len(users))
}

func TestDeleteUser(t *testing.T) {
	_, auth, firestore, router, w := InitTesting()
	ctx := context.Background()

	household, err := CreateHousehold(firestore)
	if err != nil {
		t.Error("Failed creation of household")
		return
	}

	ref, err := CreateUser(firestore, household)
	if err != nil {
		t.Error("Failed creation of user", err)
		return
	}

	fmt.Println(ref.ID)

	url := fmt.Sprintf("/user")
	req, _ := http.NewRequest("DELETE", url, nil)
	token := CreateFirebaseAuthUser(auth, ref.ID)
	bearer := "Bearer " + token
	req.Header.Set("Authorization", bearer)
	router.ServeHTTP(w, req)

	doc, err := firestore.Collection("user").Doc(ref.ID).Get(ctx)

	assert.Equal(t, false, doc.Exists())
}
