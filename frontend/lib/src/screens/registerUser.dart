import 'package:file_picker/file_picker.dart';
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
  FilePickerResult? file;

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
          width: 200.0,
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
                  file == null ? "Last opp fil" : file!.files.single.name!,
                ),
                trailing: Icon(Icons.file_upload),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);

                  if (result != null) {
                    setState(() {
                      file = result;
                    });
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 200,
                    height: 40,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    // When the user presses the button, call on the backend to create a new
                    // user with the specified name and assigned to specified household ID
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && file != null) {
                        try {
                          storageService.uploadAvatar(
                            widget.household,
                            authService.user!.uid,
                            file!.files.single.bytes!,
                            file!.files.single.name!,
                          );
                          apiService.postUser(
                            User(
                              name: _controller.text,
                              householdId: widget.household,
                            ),
                          );
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("En feil oppstod $e"),
                            ),
                          );
                          return;
                        }
                        context
                            .read<AuthService>()
                            .changeState(AuthState.SignedIn);
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
