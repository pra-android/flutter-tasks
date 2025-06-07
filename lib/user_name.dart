import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    TextEditingController userNameController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: key,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Enter  username"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setString('userName', userNameController.text);
                      Navigator.pop(context);
                    } else {
                      print("Please enter form field");
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
