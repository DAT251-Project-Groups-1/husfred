import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/api/storage_service.dart';
import 'package:frontend/src/models/user.dart';
import 'package:provider/provider.dart';

class LeaderboardTile extends StatelessWidget {
  final User user;

  LeaderboardTile(this.user);

  @override
  Widget build(BuildContext context) {
    StorageService storageService = context.watch<StorageService>();
    AuthService authService = context.watch<AuthService>();
    return Card(
      child: ListTile(
        title: Text(user.name),
        leading: FutureBuilder<String?>(
          future: storageService.getAvatar(
            ApiService.householdID,
            authService.user!.uid,
          ),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ConstrainedBox(
                constraints: BoxConstraints.tight(Size.square(24)),
                child: Image.network(snapshot.data!),
              );
            } else {
              return Icon(Icons.account_circle_rounded);
            }
          },
        ),
        trailing: Text(user.points.toString()),
      ),
    );
  }
}
