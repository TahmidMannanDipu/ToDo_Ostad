import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
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
        hintText: "Enter $text",
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  text: "description",
                  controller: descriptionController,
                  context: context),
              const SizedBox(
                height: 120,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text(
                  "Add task",
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
