import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_app/group/group_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat App"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              title: const Text("Please enter your name"),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "User must have proper name";
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    nameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String name = nameController.text;
                      nameController.clear();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GroupPage(
                            name: name,
                            userId: uuid.v1(),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Enter",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: const Text(
            "Initiate Group Chat",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
