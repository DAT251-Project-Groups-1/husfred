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

func TestNewHousehold(t *testing.T) {
	_, _, _, router, w := InitTesting()

	body := models.Household{
		Name: "Test",
	}

	postBody, _ := json.Marshal(body)
	requestBody := bytes.NewBuffer(postBody)

	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}

func TestGetHouseholdById(t *testing.T) {
	_, _, _, router, w := InitTesting()

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
	_, _, _, router, w := InitTesting()

	req, _ := http.NewRequest("GET", "/household/someID", nil)
	router.ServeHTTP(w, req)

	assert.Equal(t, 400, w.Code)
}
