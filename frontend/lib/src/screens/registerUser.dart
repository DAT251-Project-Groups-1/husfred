import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
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
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Name"),
                  onSubmitted: (String value) async {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                  ),
                  // When the user presses the button, call on the backend to create a new
                  // user with the specified name and assigned to specified household ID
                  onPressed: () async {
                    apiService.postUser(User(
                        name: _controller.text, householdId: widget.household));

                    context.read<AuthService>().changeState(AuthState.SignedIn);
                  },
                  child: Text("Register"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
