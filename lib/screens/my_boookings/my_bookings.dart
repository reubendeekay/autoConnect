import 'package:flutter/material.dart';
import 'package:mechanic/screens/my_boookings/my_bookings_tile.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/my-bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Bookings',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.1,
          backgroundColor: Colors.grey[50],
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        ),
        body: ListView(
          children: const [
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
            MyBookingsTile(),
          ],
        ));
  }
}
