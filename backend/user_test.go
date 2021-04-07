package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/DAT251-Project-Groups-1/husfred/services"
	"github.com/go-playground/assert/v2"
)

func TestUserRegistrationShouldFailIfHouseholdDoesntExist(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	postBody, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: "Nonexisting"})
	requestBody := bytes.NewBuffer(postBody)
	req, _ := http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}

func TestUserRegistrationShouldPassIfHouseholdExists(t *testing.T) {
	ctx := context.Background()
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	household, err := CreateHousehold(firestore)
	if err != nil {
		t.Error("Failed creation of household")
		return
	}

	user, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: household.ID})
	requestBody := bytes.NewBuffer(user)
	req, _ := http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	var userId string
	err = json.Unmarshal(w.Body.Bytes(), &userId)
	snapshot, err := firestore.Collection("user").Doc(userId).Get(ctx)
	if err != nil {
		fmt.Println(err)
	}
	assert.IsEqual(snapshot.Exists(), true)
}
