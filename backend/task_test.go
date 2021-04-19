package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"testing"

	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/go-playground/assert/v2"
)

func TestNewTaskShouldBeCreatedWithExsistingUserAndHousehold(t *testing.T) {
	_, _, _, router, w := InitTesting()

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
		Date:        932489234,
		Recurring:   false,
		Done:        false,
	})
	requestBody = bytes.NewBuffer(task)

	req, _ = http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestNewTaskShouldNotBeCreatedWithoutExsistingUserAndHousehold(t *testing.T) {
	_, _, _, router, w := InitTesting()

	task, _ := json.Marshal(models.Task{
		Name:        "Test Task",
		UserID:      "Nonexisting",
		HouseholdID: "Nonexisting",
		Date:        322493,
		Recurring:   false,
		Done:        false,
	})
	requestBody := bytes.NewBuffer(task)

	req, _ := http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}

func TestGetUnfinishedTasks(t *testing.T) {
	_, _, firestore, router, w := InitTesting()

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

	_, err = CreateTask(firestore, household, user, 10, false)
	if err != nil {
		t.Error("Failed creation of task")
		return
	}

	url := fmt.Sprintf("/task/%s?done=false", household.ID)
	req, _ := http.NewRequest("GET", url, nil)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestGetUnfinishedTasksInRange(t *testing.T) {
	_, _, firestore, router, w := InitTesting()

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

	_, err = CreateTask(firestore, household, user, 0, false)
	if err != nil {
		t.Error("Failed creation of task")
		return
	}

	_, err = CreateTask(firestore, household, user, 1, false)
	if err != nil {
		t.Error("Failed creation of task")
		return
	}

	url := fmt.Sprintf("/task/%s?done=false&from=1&to=2", household.ID)
	req, _ := http.NewRequest("GET", url, nil)
	router.ServeHTTP(w, req)

	var tasks []models.Task

	_ = json.Unmarshal(w.Body.Bytes(), &tasks)

	assert.Equal(t, 1, len(tasks))
}

func TestFinishTask(t *testing.T) {
	_, _, _, router, w := InitTesting()

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

	taskModel := models.Task{
		Name:        "Test Task",
		UserID:      userID,
		HouseholdID: householdID,
		Date:        3123412423,
		Recurring:   false,
		Done:        false,
	}

	task, _ := json.Marshal(taskModel)
	requestBody = bytes.NewBuffer(task)

	req, _ = http.NewRequest("POST", "/task/new", requestBody)
	router.ServeHTTP(w, req)

	req, _ = http.NewRequest("POST", "/task/finish", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}
