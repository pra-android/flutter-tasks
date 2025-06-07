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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userNameController,
                  validator: (val) {
                    return val!.isEmpty ? "Required" : null;
                  },
                  decoration: InputDecoration(hintText: "Enter  username"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      await sp.setString('userName', userNameController.text);
                      print("My name is ${sp.getString('userName')}");
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
