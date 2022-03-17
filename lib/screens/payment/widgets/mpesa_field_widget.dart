import 'package:flutter/material.dart';

class MpesaFieldWidget extends StatefulWidget {
  MpesaFieldWidget(
      {Key? key, required this.isValidate, required this.onChanged})
      : super(key: key);
  final bool isValidate;
  Function(String number) onChanged;

  @override
  State<MpesaFieldWidget> createState() => _MpesaFieldWidgetState();
}

class _MpesaFieldWidgetState extends State<MpesaFieldWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isValidate) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Mpesa Number',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              )),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  widget.onChanged(val);
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
                hintText: 'Type eg. 254796660187',
              ),
            ),
          ),
          const Text(
              'Ensure you have entered the correct phone number and have enough balance to complete the transaction')
        ],
      ),
    );
  }
}
