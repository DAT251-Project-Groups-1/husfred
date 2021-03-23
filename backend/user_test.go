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
	w := httptest.NewRecorder()

	postBody, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: "Nonexisting"})
	requestBody := bytes.NewBuffer(postBody)
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

	household, _ := json.Marshal(models.Household{Name: "Test House"})
	requestBody := bytes.NewBuffer(household)
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	householdID := w.Body.String()

	user, _ := json.Marshal(models.User{Name: "Test User", HouseholdID: householdID})
	requestBody = bytes.NewBuffer(user)
	req, _ = http.NewRequest("POST", "/user/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}
