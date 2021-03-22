package main

import (
	"bytes"
	"encoding/json"
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

	body := models.User{
		Name:        "Test User",
		HouseholdID: "skabbadu",
	}

	postBody, _ := json.Marshal(body)
	requestBody := bytes.NewBuffer(postBody)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}

func TestUserRegistrationShouldPassIfHouseholdExists(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)

	w := httptest.NewRecorder()

	//Create a household in order to bind it to the user
	householdBody := models.Household{
		Name: "Test House",
	}
	postBody, _ := json.Marshal(householdBody)
	requestBody := bytes.NewBuffer(postBody)
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	//Create the user using the id of the household
	userBody := models.User{
		Name:        "Test user",
		HouseholdID: w.Body.String(),
	}

	postBody, _ = json.Marshal(userBody)
	requestBody = bytes.NewBuffer(postBody)

	req, _ = http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}
