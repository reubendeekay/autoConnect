import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/screens/payment/widgets/payment_screen.dart';

class InitializePayment extends StatefulWidget {
  const InitializePayment({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  State<InitializePayment> createState() => _InitializePaymentState();
}

class _InitializePaymentState extends State<InitializePayment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => PaymentScreen(
            request: widget.request,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            'Initializing Payment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size.height * 0.26,
        ),
        Center(
          child: Lottie.asset('assets/pay.json'),
        ),
      ],
    );
  }
}
