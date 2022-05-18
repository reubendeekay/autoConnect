import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';

class ArrivedWidget extends StatefulWidget {
  const ArrivedWidget({Key? key}) : super(key: key);

  @override
  State<ArrivedWidget> createState() => _ArrivedWidgetState();
}

class _ArrivedWidgetState extends State<ArrivedWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Dialog(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const Text('Your Mechanic has arrived'),
                        const SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            color: kPrimaryColor,
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
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
