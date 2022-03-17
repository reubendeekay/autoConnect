import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mechanic/providers/payment_provider.dart';

class VoucherCodeWidget extends StatelessWidget {
  VoucherCodeWidget({Key? key}) : super(key: key);
  final voucherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<PaymentProvider>(
      context,
    ).message;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter voucher code here',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: voucherController,
                    onSubmitted: (val) {
                      Provider.of<PaymentProvider>(context, listen: false)
                          .validateVoucher(voucherController.text);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<PaymentProvider>(context, listen: false)
                      .validateVoucher(voucherController.text);
                },
                child: Container(
                  height: 45,
                  width: 70,
                  color: Colors.blueGrey,
                  child: const Center(child: Text('Apply')),
                ),
              )
            ],
          ),
          if (message.isNotEmpty)
            const SizedBox(
              height: 10,
            ),
          if (message.isNotEmpty)
            Text(
              message,
              style: const TextStyle(fontSize: 12, color: Colors.orange),
            ),
        ],
      ),
    );
  }
}
