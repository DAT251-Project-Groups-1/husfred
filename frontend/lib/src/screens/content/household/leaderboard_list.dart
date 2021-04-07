import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/household/leaderboard_tile.dart';
import 'package:frontend/src/screens/content/todo/todoTile.dart';
import 'package:provider/provider.dart';

class LeaderboardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, state, _) {
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, i) => LeaderboardTile(state.users[i]),
        );
      },
    );
  }
}
