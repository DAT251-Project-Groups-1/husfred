export GOOGLE_APPLICATION_CREDENTIALS=service-account.json
export FIRESTORE_EMULATOR_HOST=localhost:8090
export GIN_MODE=release
firebase emulators:exec "go test"
