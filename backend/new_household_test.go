package main

import (
	"github.com/DAT251-Project-Groups-1/husfred/controllers"
	"github.com/DAT251-Project-Groups-1/husfred/models"
	"github.com/DAT251-Project-Groups-1/husfred/services"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
	"net/http/httptest"
	"testing"
)

func TestNewHousehold(t *testing.T) {
	w := httptest.NewRecorder()
	ctx, _ := gin.CreateTestContext(w)

	// BEGIN Testing directly with production firebase
	firebase := services.InitFirebase()
	firestore := services.InitFirestore(firebase)
	ctx.Set("firestore", firestore)
	// END

	input := models.Household{
		Name:  "Test",
		Users: []string{"User1"},
		Tasks: []string{"Task1"},
	}
	err := ctx.Bind(input)
	if err != nil {
		t.Fatal(err)
	}
	controllers.NewHousehold(ctx)

	assert.IsEqual( 200, w.Code)
}
