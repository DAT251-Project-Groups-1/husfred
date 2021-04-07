import 'package:flutter/material.dart';
import 'package:frontend/src/models/user.dart';

class LeaderboardTile extends StatelessWidget {
  User user;

  LeaderboardTile(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        leading: Icon(Icons.account_circle),
        trailing: Text(user.points.toString()),
      ),
    );
  }
}
