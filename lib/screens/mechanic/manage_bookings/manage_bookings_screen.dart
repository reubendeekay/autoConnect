import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/screens/mechanic/manage_bookings/widgets/manage_booking_tile.dart';

class ManageBookingsScreen extends StatelessWidget {
  const ManageBookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/manage-bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Bookings'),
          // automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
        ),
        body: ListView(
          children: List.generate(10, (index) => const ManageBookingsTile()),
        ));
  }
}
