import 'package:flutter/material.dart';
import 'LoginPage.dart'; // Corrected import statement

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        LoginPage()), // Corrected MaterialPageRoute usage
                (Route<dynamic> route) => false,
              );
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Welcome to Flutter!",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
