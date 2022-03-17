import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/mechanic_profile/service_details_screen.dart';

class RequestServiceButton extends StatelessWidget {
  const RequestServiceButton({Key? key, required this.mechanic})
      : super(key: key);
  final MechanicModel mechanic;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 45,
      width: size.width,
      child: RaisedButton(
        color: kPrimaryColor,
        onPressed: () {
          Get.to(() => ServiceDetailsScreen(mech: mechanic));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: const Text(
          'Request Service',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
