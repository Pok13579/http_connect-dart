import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future register() async {
    var url =
        Uri.http("10.200.30.234", '/flutter/register.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "username": user.text.toString(),
      "password": pass.text.toString(),
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exit!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
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
          "Sign up with",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF3D657),
            height: 2,
          ),
        ),
        const Text(
          "Example Signup",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF3D657),
            letterSpacing: 2,
            height: 1,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          style: const TextStyle(color: Colors.white),
          controller: user,
          decoration: InputDecoration(
            hintText: 'Enter Email / Username',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
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
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          controller: pass,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
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
            fillColor: Colors.grey.withOpacity(0.1),
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
            color: const Color(0xFFF3D657),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF3D657).withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
              child: GestureDetector(
            onTap: register,
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1C),
              ),
            ),
          )),
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          "Or Signup with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF3D657),
            height: 1,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              FontAwesomeIcons.instagram,
              size: 100,
            ),
            Icon(
              FontAwesomeIcons.facebook,
              size: 100,
            ),
            Icon(
              FontAwesomeIcons.whatsapp,
              size: 100,
            ),
          ],
        )
      ],
    );
  }
}
