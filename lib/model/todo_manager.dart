import 'package:flutter/material.dart';
import 'package:todo_ostad/model/todo.dart';

class ToDoManager {
  final List<ToDo> _listofToDo = [];

  List<ToDo> get todoList => _listofToDo;

  void addToDo(ToDo todo) {
    _listofToDo.add(todo);
  }

  void deleteToDo(int index) {
    _listofToDo.removeAt(index);
  }

  void updateToDo(ToDo todo, int index) {
    _listofToDo[index] = todo;
  }
}
