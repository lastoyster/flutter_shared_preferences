import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Corrected import

import 'HomeScreen.dart'; // Corrected import

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool checkValue = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
      ),
      body: SingleChildScrollView(
        child: _body(),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30.0),
            child: Image.asset(
              "assets/image/flutter_icon.png", // Corrected asset path
              height: 100.0,
            ),
          ),
          TextField(
            controller: username,
            decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3))),
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3))),
          ),
          CheckboxListTile(
            value: checkValue,
            onChanged: _onChanged,
            title: Text("Remember Me"),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          ElevatedButton(
            onPressed: _navigator,
            child: Text("Login"),
          ),
        ],
      ),
    );
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
      sharedPreferences.commit();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check") ??
          false; // Added null check with default value
      if (checkValue) {
        username.text = sharedPreferences.getString("username") ?? "";
        password.text = sharedPreferences.getString("password") ?? "";
      } else {
        username.clear();
        password.clear();
        sharedPreferences.clear();
      }
    });
  }

  _navigator() {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      // Simplified condition
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text(
            "Username or password cannot be empty",
            style: TextStyle(fontSize: 16.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
