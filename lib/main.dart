//user register and login
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:http_conect/login.dart';
import 'package:http_conect/login_option.dart';
import 'package:http_conect/signup.dart';
import 'package:http_conect/signup_option.dart';

//import 'dart:ui' as ui;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //textTheme: GoogleFonts.muktaVaaniTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: login ? const Login() : const LoginOption(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: login ? 55 : 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: !login ? const SignUp() : const SignUpOption(),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = const RadialGradient(
      colors: [
        Colors.blue,
        Colors.purpleAccent,
      ],
    ).createShader(Rect.fromCircle(
      radius: 600,
      center: const Offset(50, 50),
    ));
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
