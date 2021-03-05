package main

import (
	"github.com/DAT251-Project-Groups-1/husfred/config"
	"github.com/DAT251-Project-Groups-1/husfred/controllers"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
	"net/http/httptest"
	"testing"
)

func TestNewHousehold(t *testing.T) {
	w := httptest.NewRecorder()
	ctx, _ := gin.CreateTestContext(w)

	// BEGIN Testing directly with production firebase
	firebase := config.InitFirebase()
	firestore := config.InitFirestore(firebase)
	ctx.Set("firestore", firestore)
	// END

	controllers.NewHousehold(ctx)

	assert.IsEqual( 200, w.Code)
}
