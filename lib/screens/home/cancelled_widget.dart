import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/auth_provider.dart';

class CancelledWidget extends StatefulWidget {
  const CancelledWidget(
      {Key? key, required this.request, this.isDenied = false})
      : super(key: key);
  final RequestModel request;
  final bool isDenied;

  @override
  State<CancelledWidget> createState() => _CancelledWidgetState();
}

class _CancelledWidgetState extends State<CancelledWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (ctx) => Dialog(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          widget.isDenied
                              ? 'Request Denied'
                              : 'Request Cancelled',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                          child: Lottie.asset('assets/cancel.json'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.request.mechanic!.name!} has ${widget.isDenied ? 'denied' : 'cancelled'} your request. Dont fret! Try another mechanic',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('userData')
                                .doc('bookings')
                                .collection(uid)
                                .doc(widget.request.id)
                                .update({
                              'status': 'failed',
                            });

                            Navigator.of(ctx).pop();
                          },
                          color: kPrimaryColor,
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
