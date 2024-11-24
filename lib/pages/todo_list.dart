import 'package:flutter/material.dart';
import 'package:todo_ostad/pages/update_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void _updateStatus(String newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  String status = "Status";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Title of Todo"),
      subtitle: const Text("Description"),
      leading: Text(status),
      onTap: () {
        _showChangeStatusDialog(context);
      },
      trailing: Wrap(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdateTodo()),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  void _showChangeStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Idle"),
                onTap: () {
                  _updateStatus("Idle");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("In Progress"),
                onTap: () {
                  _updateStatus("In Progress");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Done"),
                onTap: () {
                  _updateStatus("Done");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
