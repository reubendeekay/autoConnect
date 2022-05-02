import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanic/helpers/mpesa_helper.dart';
import 'package:mechanic/helpers/my_loader.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/screens/payment/widgets/thank_you_screen.dart';
import 'package:provider/provider.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/providers/payment_provider.dart';
import 'package:mechanic/screens/payment/widgets/card_field_widget.dart';
import 'package:mechanic/screens/payment/widgets/mpesa_field_widget.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({Key? key, required this.index, required this.request})
      : super(key: key);
  final int index;
  final RequestModel request;

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String? phoneNumber;
  bool isValidate = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.index;
    List<Widget> screens = [
      const CardFieldWidget(),
      MpesaFieldWidget(
        isValidate: isValidate,
        onChanged: (val) {
          setState(() {
            phoneNumber = val;
          });
        },
      ),
      const CardFieldWidget(),
      const CardFieldWidget(),
    ];
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      margin: const EdgeInsets.only(top: 10),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          Expanded(child: screens[currentIndex]),
          Center(
            child: Container(
              width: size.width * 0.8,
              height: 50,
              margin: const EdgeInsets.all(12),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  setState(() {
                    isValidate = true;
                    isLoading = true;
                  });
                  if (currentIndex == 1) {
                    try {
                      await mpesa.lipaNaMpesa(
                        phoneNumber: phoneNumber.toString(),
                        amount: double.parse(widget.request.amount!.toString()),
                        accountReference: 'AutoConnect',
                        businessShortCode: "174379",
                        // callbackUrl:
                        //     "https://us-central1-my-autoconnect.cloudfunctions.net/lmno_callback_url/user?uid=$uid/${widget.request.amount}/${widget.request.mechanic!.id!}",
                        callbackUrl: "https://google.com/",
                      );
                      Get.off(
                        ThankYouPage(
                          request: widget.request,
                        ),
                      );

                      setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      Get.off(
                        ThankYouPage(
                          request: widget.request,
                        ),
                      );
                    }
                  }
                  // await mpesaPayment(
                  //   amount:
                  //       pricing.price - pricing.voucher - pricing.shipping,
                  //   phone: phoneNumber.toString(),
                  // );
                },
                color: kPrimaryColor,
                child: isLoading
                    ? const MyLoader()
                    : Text(
                        'Pay KES ${widget.request.amount}',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
