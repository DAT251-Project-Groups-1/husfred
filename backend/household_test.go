package main

import (
	"bytes"
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

func TestNewHousehold(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)

	body := models.Household{
		Name: "Test",
	}

	postBody, _ := json.Marshal(body)
	requestBody := bytes.NewBuffer(postBody)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestGetHouseholdById(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	household, _ := json.Marshal(models.Household{Name: "Test Get House"})
	requestBody := bytes.NewBuffer(household)
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	householdID := w.Body.String()

	url := fmt.Sprintf("/household/%s", householdID)
	req, _ = http.NewRequest("GET", url, requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestGetHouseholdShouldFailWithoutExistingID(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	req, _ := http.NewRequest("GET", "/household/someID", nil)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}
