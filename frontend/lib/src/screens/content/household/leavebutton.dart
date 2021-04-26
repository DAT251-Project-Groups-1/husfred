import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/models/user.dart';
import 'package:provider/provider.dart';

class LeaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: Text('Leave household'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  ApiService apiService = context.watch<ApiService>();
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget leaveButton = TextButton(
    child: Text("Leave"),
    onPressed: () async {
      apiService.deleteUser();
      context.read<AuthService>().changeState(AuthState.Initialized);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Leave household?"),
    content: Text(
        "Are you sure you want to leave this household? All acquired points will be lost."),
    actions: [
      cancelButton,
      leaveButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
