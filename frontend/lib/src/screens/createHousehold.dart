import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/models/household.dart';
import 'package:provider/provider.dart';

class CreateHousehold extends StatefulWidget {
  const CreateHousehold({Key? key}) : super(key: key);

  @override
  _CreateHouseholdState createState() => _CreateHouseholdState();
}

class _CreateHouseholdState extends State<CreateHousehold> {
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
        title: Text("Create Household"),
      ),
      body: Center(
        child: Container(
          width: 250.0,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Household name"),
                  onSubmitted: (String value) async {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 250,
                    height: 40,
                  ),
                  child: ElevatedButton(
                    // When the user presses the button, show an alert dialog containing the
                    // text that the user has entered into the text field.
                    onPressed: () async {
                      await apiService
                          .postHousehold(Household(name: _controller.text));
                      context
                          .read<AuthService>()
                          .changeState(AuthState.Register);
                    },
                    child: Text("Create"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
