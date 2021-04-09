import 'package:flutter/material.dart';
import 'package:frontend/src/models/task.dart';

class FeedTile extends StatefulWidget {
  final Task task;

  FeedTile(this.task);

  @override
  _FeedTileState createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
  bool hasVoted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(widget.task.name),
            leading: Icon(Icons.account_circle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  // Visual hack, obv fix when adding backend
                  hasVoted ? "1" : "0",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    icon:
                        Icon(hasVoted ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        // Fix when adding backend
                        hasVoted = !hasVoted;
                      });
                    }),
              ],
            )));
  }
}
