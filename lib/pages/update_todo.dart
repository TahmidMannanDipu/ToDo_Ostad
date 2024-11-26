import 'package:flutter/material.dart';

import '../model/todo.dart';

class UpdateTodo extends StatefulWidget {
  final ToDo todoUpdate;
  final  Function(ToDo) onUpdateTodo;
   UpdateTodo({super.key,required this.todoUpdate, required this.onUpdateTodo});

  @override
  State<UpdateTodo> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<UpdateTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Widget buildTextFormField({
    required String text,
    required TextEditingController controller,
    required BuildContext context,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: controller,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "$text Cannot Be Empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Update $text",
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    titleController.text = widget.todoUpdate.title;
    descriptionController.text= widget.todoUpdate.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update new task"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // for title
                buildTextFormField(
                    text: "Title", controller: titleController, context: context),
                const SizedBox(
                  height: 40,
                ),
                // for description
                buildTextFormField(
                    text: "description", controller: descriptionController, context: context),
                const SizedBox(
                  height: 120,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ToDo todo = ToDo(title: titleController.text.trim(),
                          description: descriptionController.text.trim());
                      widget.onUpdateTodo(todo);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "Update task",
                    style: TextStyle(fontSize: 22, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
