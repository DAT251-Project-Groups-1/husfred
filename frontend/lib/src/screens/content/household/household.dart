import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/household/leaderboard_list.dart';
import 'package:frontend/src/screens/content/household/leavebutton.dart';
import 'package:frontend/src/screens/content/household/link_button.dart';
import 'package:provider/provider.dart';

class Household extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Household"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: context.read<ApiService>().getLeaderboard(),
              builder: (context, snapshot) {
                return LeaderboardList();
              },
            ),
          ),
          LinkButton(),
          LeaveButton(),
        ],
      ),
    );
  }
}
