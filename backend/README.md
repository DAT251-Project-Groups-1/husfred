# How to run
1. `export GOOGLE_APPLICATION_CREDENTIALS="service-account.json"`
2. `go run main.go`


# How to run (local)
1. `export GOOGLE_APPLICATION_CREDENTIALS="service-account.json"`
2. `export FIRESTORE_EMULATOR_HOST="localhost:8090"`
3. `firebase emulators:start`
4. `go run main.go`


# How to test
1. export FIRESTORE_EMULATOR_HOST="localhost:8090"
2. `go test`

# Run tests locally
* ./test_local.sh
