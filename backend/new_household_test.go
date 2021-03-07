package main

/*func TestNewHousehold(t *testing.T) {
	firebase := services.InitFirebase()
	auth := services.InitAuth(firebase)
	firestore := services.InitFirestore(firebase)
	router := SetupRouter(auth, firestore)

	body := models.Household{
		Name:  "Test",
		Users: []string{"User1"},
		Tasks: []string{"Task1"},
	}

	postBody, _:= json.Marshal(body)
	requestBody := bytes.NewBuffer(postBody)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/household/new", requestBody)
	router.ServeHTTP(w, req)

	assert.Equal(t, 200, w.Code)
}*/
