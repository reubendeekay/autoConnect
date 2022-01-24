import 'package:flutter/material.dart';
import 'package:mechanic/screens/auth/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment(0, 1),
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/home-bg.png"),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.0,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Have some\nproblem with",
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 26.0,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "\nyour Vehicle?",
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const LoginForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
