// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/loading_screen.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/drawer/hidden_drawer.dart';
import 'package:mechanic/screens/home/homepage.dart';
import 'package:provider/provider.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<MechanicProvider>(context, listen: false)
          .payRequest(widget.request);
      Future.delayed(Duration(seconds: 3), () {
        Get.offAll(() => InitialLoadingScreen());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Lottie.asset(
            'assets/hurray.json',
            repeat: false,
            width: screenWidth,
            height: screenHeight,
          ),
        ),
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Lottie.asset(
                  "assets/card.json",
                  repeat: false,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Thank You!",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Payment done Successfully",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "You will be redirected to the home page shortly\nor click here to return to home page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Flexible(
                  child: GestureDetector(
                onTap: () async {
                  await Provider.of<MechanicProvider>(context, listen: false)
                      .payRequest(widget.request);
                  Get.offAll(() => HidenDrawer());
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ))
            ])),
      ],
    ));
  }
}
