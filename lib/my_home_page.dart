import 'package:flutter/material.dart';
import 'package:flutter_task/user_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = '';
  int count = 0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      count = prefs.getInt('counter') ?? 0;

      isLoading = false;
    });
  }

  Future<void> updateCounter(int newCount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      count = newCount;
    });
    await prefs.setInt('counter', newCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserName()),
                );
                loadData();
              },
              child:
                  userName.isEmpty
                      ? Text(
                        "Hi, _ _ _",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : Text(userName),
            ),
          ),
          Text("Your count is:"),
          SizedBox(height: 20),
          Text(count.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: InkWell(
                  onTap: () {
                    if (userName!.isNotEmpty) {
                      updateCounter(count + 1);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("+"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: InkWell(
                  onTap: () {
                    if (userName!.isNotEmpty) {
                      updateCounter(count - 1);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("-"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
