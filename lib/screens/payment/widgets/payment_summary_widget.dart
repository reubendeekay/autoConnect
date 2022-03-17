import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mechanic/providers/payment_provider.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pricing = Provider.of<PaymentProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Payment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          expenseItem(
              'Item(s) Price', 'KES ' + pricing.price.toStringAsFixed(0)),
          expenseItem(
              'Shipping Price', 'KES ' + pricing.shipping.toStringAsFixed(0)),
          expenseItem('Voucher', '- KES ' + pricing.voucher.toStringAsFixed(0)),
        ],
      ),
    );
  }

  Widget expenseItem(String title, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Text(amount),
        ],
      ),
    );
  }
}
