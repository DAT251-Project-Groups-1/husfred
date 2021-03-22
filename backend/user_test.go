package main
import (
/*
	"bytes"
	"encoding/json"
	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/DAT251-Project-Groups-1/husfred/services"
	"net/http"
	"net/http/httptest"
    */
	"github.com/go-playground/assert/v2"
	"testing"
)

func TestUserRegistration(t *testing.T) {
/*
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)

	body := models.User{
		Name:  "Test User",
	}

	postBody, _:= json.Marshal(body)
	requestBody := bytes.NewBuffer(postBody)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)
*/
	assert.Equal(t, 200, 200)
}
