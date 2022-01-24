import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/screens/auth/auth_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const SplashVideoScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          'AutoConnect',
          textAlign: TextAlign.center,
          style: GoogleFonts.averiaLibre(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: Colors.white),
        ),
      ),
    );
  }
}

class SplashVideoScreen extends StatefulWidget {
  const SplashVideoScreen({Key? key}) : super(key: key);

  @override
  _SplashVideoScreenState createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/bg_video4.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() =>  AuthScreen());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: _controller.value.size.height,
                width: _controller.value.size.width,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 6,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Need vehicle services? Explore and Disover mechanics around you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          'AutoConnect',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
