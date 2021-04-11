package main

import (
	"bytes"
	"cloud.google.com/go/firestore"
	"context"
	"encoding/json"
	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"fmt"
	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/services"
	"github.com/gin-gonic/gin"
	"io/ioutil"
	"net/http"
	"net/http/httptest"

	"github.com/DAT251-Project-Groups-1/husfred/models"
)

type GoogleIdToken struct {
	Expiresin    string `json:"expiresIn"`
	Idtoken      string `json:"idToken"`
	Isnewuser    bool   `json:"isNewUser"`
	Kind         string `json:"kind"`
	Refreshtoken string `json:"refreshToken"`
}

func InitTesting() (*firebase.App, *auth.Client, *firestore.Client, *gin.Engine, *httptest.ResponseRecorder) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := config.SetupRouter(auth, firestore)
	w := httptest.NewRecorder()

	return firebase, auth, firestore, router, w
}

func CreateHousehold(client *firestore.Client) (*firestore.DocumentRef, error) {
	ctx := context.Background()
	household := models.Household{Name: "Test House"}
	ref, _, err := client.Collection("household").Add(ctx, household)
	return ref, err
}

func CreateUser(client *firestore.Client, hh *firestore.DocumentRef) (*firestore.DocumentRef, error) {
	ctx := context.Background()
	user := models.User{Name: "Test User", HouseholdID: hh.ID, Points: 0}
	ref, _, err := client.Collection("user").Add(ctx, user)
	return ref, err
}

func CreateFirebaseAuthUser(auth *auth.Client) string {
	ctx := context.Background()
	token, _ := auth.CustomToken(ctx, "testUser")
	var body = map[string]interface{}{
		"token":             token,
		"returnSecureToken": true,
	}

	marshal, _ := json.Marshal(body)
	requestBody := bytes.NewBuffer(marshal)
	apiKey := "AIzaSyA5ArYmOPtp4W6WzR66I6mi-Xt4UlsoMvM"
	url := fmt.Sprintf("https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=%s", apiKey)
	res, _ := http.Post(url, "application/json", requestBody)
	defer res.Body.Close()
	all, _ := ioutil.ReadAll(res.Body)

	var IDToken GoogleIdToken

	_ = json.Unmarshal(all, &IDToken)
	return IDToken.Idtoken
}
