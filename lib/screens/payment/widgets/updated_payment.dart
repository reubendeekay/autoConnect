import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/payment/widgets/payment_screen.dart';
import 'package:mechanic/screens/report_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatedPayment extends StatelessWidget {
  const UpdatedPayment({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const Text(
              'The payment has been updated',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: Lottie.asset('assets/pay.json'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New amount to be paid is KES '),
                Text(
                  request.amount!,
                  style: const TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Get.to(() => ReportScreen(request: request));
                  },
                  color: Colors.red,
                  child: const Text(
                    'Report',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(() => PaymentScreen(request: request));
                  },
                  color: kPrimaryColor,
                  child:
                      const Text('Pay ', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class UpdatedPaymentContainer extends StatefulWidget {
  const UpdatedPaymentContainer({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<UpdatedPaymentContainer> createState() =>
      _UpdatedPaymentContainerState();
}

class _UpdatedPaymentContainerState extends State<UpdatedPaymentContainer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (ctx) => UpdatedPayment(request: widget.request));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
