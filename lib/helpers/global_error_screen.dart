import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/loading_screen.dart';

class GlobalErrorScreen extends StatefulWidget {
  const GlobalErrorScreen({Key? key}) : super(key: key);

  @override
  State<GlobalErrorScreen> createState() => _GlobalErrorScreenState();
}

class _GlobalErrorScreenState extends State<GlobalErrorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Get.off(() => const InitialLoadingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/17_Location Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 25,
                    color: Colors.black.withOpacity(0.17),
                  ),
                ],
              ),
              child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Get.off(() => const InitialLoadingScreen());
                },
                child: Text("Refresh".toUpperCase()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
