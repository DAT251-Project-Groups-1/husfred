set GOOGLE_APPLICATION_CREDENTIALS=service-account.json
set FIRESTORE_EMULATOR_HOST=localhost:8090
set GIN_MODE=release
firebase emulators:exec "go test"
