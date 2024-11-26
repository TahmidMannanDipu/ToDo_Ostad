import 'package:flutter/material.dart';
import 'package:todo_ostad/model/todo.dart';
import 'package:todo_ostad/pages/update_todo.dart';

import 'add_new_task.dart';

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
  final List<ToDo> listofToDo = [];

  void _addToDo(ToDo todo) {
    listofToDo.add(todo);
    setState(() {});
  }

  void _deleteToDo(int index) {
    listofToDo.removeAt(index);
    setState(() {});
  }

  void _updateToDo(ToDo todo, int index) {
    listofToDo[index] = todo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo List"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ToDo? todo = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTask(),

              ),
            );
            if (todo!=null){
              _addToDo(todo);
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
        body: Visibility(
      visible: listofToDo.isNotEmpty,
      replacement: const Center(
        child: Text("Empty List"),
      ),
      child: ListView.builder(
          itemCount: listofToDo.length,
          itemBuilder: (context, index) {
            ToDo todo = listofToDo[index];
            return ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              leading: Text(status),
              onTap: () {
                _showChangeStatusDialog(context);
              },
              trailing: Wrap(
                children: [
                  IconButton(onPressed: () {
                    _deleteToDo(index);
                  }, icon: const Icon(Icons.delete)),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateTodo(
                              todoUpdate: todo,
                              onUpdateTodo: (ToDo updateTodo){
                                _updateToDo(updateTodo, index);
                              },
                            )),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            );
          }),
    ));
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
