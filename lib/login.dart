import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = Uri.http("10.200.30.234", '/flutter/login.php', {'q': '{http}'});
    try {
      var response = await http.post(url, body: {
        "username": user.text,
        "password": pass.text,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle the different response cases
        if (data == "Success") {
          Fluttertoast.showToast(
            msg: 'Login Successful',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashBoard(),
            ),
          );
        } else if (data == "Username does not exist") {
          Fluttertoast.showToast(
            msg: 'Username does not exist',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else if (data == "Incorrect password") {
          Fluttertoast.showToast(
            msg: 'Incorrect password',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } 
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
            height: 2,
          ),
        ),
        const Text(
          "Example Login Page",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
            letterSpacing: 2,
            height: 1,
          ),
        ),
        const Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
            height: 1,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: user,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Email / Username',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          controller: pass,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1C1C1C).withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
              child: GestureDetector(
            onTap: login,
            child: const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "FORGOT PASSWORD?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
            height: 1,
          ),
        ),
      ],
    );
  }
}
