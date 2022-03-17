import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/screens/mechanic/manage_bookings/widgets/admin_booking_details.dart';

class ManageBookingsTile extends StatelessWidget {
  const ManageBookingsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        child: Center(
          child: Icon(
            Icons.person,
            size: 45,
            color: Colors.white,
          ),
        ),
      ),
      title: const Text('Car Repair'),
      subtitle: const Text('By Reuben Jefwa'),
      trailing: const Text('11:30'),
      onTap: () {
        Get.to(() => const AdminBookingDetails());
      },
    );
  }
}
