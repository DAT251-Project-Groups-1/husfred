export GOOGLE_APPLICATION_CREDENTIALS=service-account.json
export FIRESTORE_EMULATOR_HOST=localhost:8090
firebase emulators:exec ./test.sh 
