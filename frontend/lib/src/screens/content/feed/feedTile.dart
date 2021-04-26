import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/api/auth_service.dart';
import 'package:frontend/src/models/task.dart';
import 'package:provider/provider.dart';

class FeedTile extends StatefulWidget {
  final Task task;

  FeedTile(this.task);

  @override
  _FeedTileState createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
  @override
  Widget build(BuildContext context) {
    var authService = context.read<AuthService>();
    var apiService = context.read<ApiService>();
    var votes = widget.task.votes;
    var userID = authService.user!.uid;
    bool hasVoted = votes.contains(userID);
    print(widget.task.votes);
    return Card(
        child: ListTile(
            title: Text(widget.task.name),
            leading: Icon(Icons.account_circle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  (votes.length).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    icon:
                        Icon(hasVoted ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      if (hasVoted) {
                        votes.removeWhere((item) => item == userID);
                      } else {
                        votes.add(userID);
                      }
                      apiService.voteTask(widget.task);
                    }),
              ],
            )));
  }
}
