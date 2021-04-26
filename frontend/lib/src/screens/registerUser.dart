import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/api/storage_service.dart';
import 'package:frontend/src/models/user.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  final String household;

  const RegisterUser({Key? key, required this.household}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  PickedFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = context.watch<ApiService>();
    StorageService storageService = context.watch<StorageService>();
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Container(
          width: 250.0,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (String? value) => value == null || value.isEmpty
                        ? "Vennligst fyll inn"
                        : null,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  _pickedFile == null ? "Pick file" : "Change avatar",
                ),
                trailing: _pickedFile == null
                    ? Icon(Icons.file_upload)
                    : (kIsWeb
                        ? Image.network(_pickedFile!.path)
                        : Image.file(File(_pickedFile!.path))),
                onTap: () async {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);

                  setState(() {
                    if (pickedFile != null) {
                      _pickedFile = pickedFile;
                    } else {
                      print('No image selected.');
                    }
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 250,
                    height: 40,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _pickedFile != null) {
                        final fileAsBytes = await _pickedFile!.readAsBytes();
                        await storageService.uploadAvatar(
                          widget.household,
                          authService.user!.uid,
                          fileAsBytes,
                        );
                        apiService.postUser(
                          User(
                            name: _controller.text,
                            householdId: widget.household,
                          ),
                        );

                        authService.changeState(AuthState.SignedIn);
                      }
                    },
                    child: Text("Register"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
