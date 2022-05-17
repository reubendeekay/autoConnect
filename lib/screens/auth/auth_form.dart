import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/helpers/my_loader.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/screens/auth/auth_exception.dart';
import 'package:mechanic/screens/auth/input_widget.dart';
import 'package:mechanic/screens/drawer/hidden_drawer.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLogin = true;
  bool isLoading = false;
  bool isObscure = true;

  String? email;
  String? password;
  String? phoneNumber;
  String? fullName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLogin)
          InputWidget(
            hintText: "Full name",
            onChanged: (val) {
              setState(() {
                fullName = val;
              });
            },
            suffixIcon: const Icon(
              Icons.person_outline,
              color: Color.fromRGBO(105, 108, 121, 1),
            ),
          ),
        if (!isLogin)
          const SizedBox(
            height: 15.0,
          ),
        if (!isLogin)
          InputWidget(
            hintText: "Phone number",
            onChanged: (val) {
              setState(() {
                phoneNumber = val;
              });
            },
            suffixIcon: const Icon(
              Icons.phone_outlined,
              color: Color.fromRGBO(105, 108, 121, 1),
            ),
          ),
        if (!isLogin)
          const SizedBox(
            height: 15.0,
          ),
        InputWidget(
          hintText: "Email",
          onChanged: (val) {
            setState(() {
              email = val;
            });
          },
          suffixIcon: const Icon(
            Icons.email_outlined,
            color: Color.fromRGBO(105, 108, 121, 1),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        InputWidget(
          hintText: "Password",
          obscureText: isObscure,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            child: Icon(
              isObscure
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: const Color.fromRGBO(105, 108, 121, 1),
            ),
          ),
          onChanged: (val) {
            setState(() {
              password = val;
            });
          },
        ),
        const SizedBox(
          height: 25.0,
        ),
        isLoading
            ? Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(32.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(169, 176, 185, 0.42),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: const MyLoader(),
              )
            : PrimaryButton(
                text: isLogin ? "Login" : 'Register',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final auth =
                      Provider.of<AuthProvider>(context, listen: false);
                  if (isLogin) {
                    final status = await auth.login(
                      email: email!.trim(),
                      password: password!.trim(),
                    );
                    if (status == AuthResultStatus.successful) {
                      Get.off(() => HidenDrawer());
                    } else {
                      final errorMsg =
                          AuthExceptionHandler.generateExceptionMessage(status);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorMsg,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    final status = await auth.signUp(
                      email: email!.trim(),
                      password: password!.trim(),
                      fullName: fullName,
                      phoneNumber: phoneNumber!.trim(),
                    );
                    if (status == AuthResultStatus.successful) {
                      Get.off(() => const InitialLoadingScreen());
                    } else {
                      final errorMsg =
                          AuthExceptionHandler.generateExceptionMessage(status);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(errorMsg,
                              style: const TextStyle(color: Colors.white)),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
        const SizedBox(
          height: 20.0,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  isLogin
                      ? 'Don\'t have an account? '
                      : 'Already have an account? ',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  )),
              Text(isLogin ? 'Register ' : 'Log in',
                  style: const TextStyle(
                    color: kPrimaryColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Function onPressed;
  const PrimaryButton({Key? key, this.text, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
