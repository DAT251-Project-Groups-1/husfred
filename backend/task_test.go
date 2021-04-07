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

func TestNewTaskShouldBeCreatedWithExsistingUserAndHousehold(t *testing.T) {
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

	userID := w.Body.String()

	task, _ := json.Marshal(models.Task{
		Name:        "Test Task",
		UserID:      userID,
		HouseholdID: householdID,
		Date:        "20.01.2021",
		Recurring:   false,
		Done:        false,
	})
	requestBody = bytes.NewBuffer(task)

	req, _ = http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestNewTaskShouldNotBeCreatedWithoutExsistingUserAndHousehold(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	task, _ := json.Marshal(models.Task{
		Name:        "Test Task",
		UserID:      "Nonexisting",
		HouseholdID: "Nonexisting",
		Date:        "20.01.2021",
		Recurring:   false,
		Done:        false,
	})
	requestBody := bytes.NewBuffer(task)

	req, _ := http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}

func TestGetUnfinishedTasks(t *testing.T) {
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

	user, err := CreateUser(firestore, household)
	if err != nil {
		t.Error("Failed creation of household")
		return
	}

	task, _ := json.Marshal(models.Task{Name: "Test Task 1", HouseholdID: household.ID, Done: false, UserID: user.ID})
	requestBody := bytes.NewBuffer(task)
	req, _ := http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	url := fmt.Sprintf("/task/%s?done=false", household.ID)
	req, _ = http.NewRequest("GET", url, requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}
