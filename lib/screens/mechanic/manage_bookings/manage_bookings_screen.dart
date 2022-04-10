import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/mechanic/manage_bookings/widgets/manage_booking_tile.dart';
import 'package:provider/provider.dart';

class ManageBookingsScreen extends StatelessWidget {
  const ManageBookingsScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/manage-bookings';

  @override
  Widget build(BuildContext context) {
    final mechanic = Provider.of<AuthProvider>(context).mechanic;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Bookings'),
          // automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .doc('mechanics')
                .collection(mechanic!.id!)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return ListView(
                children: List.generate(
                  docs.length,
                  (index) => ManageBookingsTile(
                    booking: RequestModel.fromJson(docs[index]),
                  ),
                ),
              );
            }));
  }
}
