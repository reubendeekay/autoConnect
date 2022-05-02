import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/drawer/hidden_drawer.dart';
import 'package:provider/provider.dart';

class RequestAnimationScreen extends StatefulWidget {
  const RequestAnimationScreen({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<RequestAnimationScreen> createState() => _RequestAnimationScreenState();
}

class _RequestAnimationScreenState extends State<RequestAnimationScreen> {
  bool isFinished = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<MechanicProvider>(context, listen: false)
          .requestBooking(widget.request);
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        isFinished = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAll(() => HidenDrawer());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: size.height * 0.25,
            ),
            Lottie.asset('assets/request.json'),
          ],
        ),
        AnimatedPositioned(
            bottom: isFinished ? size.height * 0.3 : -100,
            child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: isFinished ? 1 : 0,
                child: SizedBox(
                  width: size.width,
                  child: const Center(
                      child: Text(
                    'Request Sent',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                )),
            duration: const Duration(milliseconds: 500))
      ]),
    );
  }
}
