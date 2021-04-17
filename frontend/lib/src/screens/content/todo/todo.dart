import 'package:flutter/material.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/screens/content/todo/newTask.dart';
import 'package:frontend/src/screens/content/todo/progress_ring.dart';
import 'package:frontend/src/screens/content/todo/todoList.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int pageIndex = 0;
  late DateTime from;
  late DateTime to;

  @override
  void initState() {
    super.initState();
    getTasks(context, pageIndex);
  }

  void getTasks(BuildContext context, int weekDiff) {
    int relativeDays = ++weekDiff * 7;

    from = DateTime.now()
        .subtract(Duration(days: DateTime.now().weekday - relativeDays + 6));
    to = DateTime.now()
        .add(Duration(days: relativeDays - DateTime.now().weekday));
    context.read<ApiService>().getTasks(false, from, to);
    context.read<ApiService>().getTasks(true, from, to);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return NewTask();
            },
          ).whenComplete(() => getTasks(context, pageIndex));
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 40,
                  icon: Icon(
                    Icons.chevron_left,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      getTasks(context, --pageIndex);
                    });
                  },
                ),
              ),
              Text(DateFormat("dd/MM").format(from)),
              Spacer(),
              Text(DateFormat("dd/MM").format(to)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 40,
                  icon: Icon(
                    Icons.chevron_right,
                  ),
                  onPressed: () {
                    setState(() {
                      getTasks(context, ++pageIndex);
                    });
                  },
                ),
              ),
            ],
          ),
          ProgressRing(
            progress: context.watch<ApiService>().taskProgress,
          ),
          Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
