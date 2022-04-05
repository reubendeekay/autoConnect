import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/screens/my_boookings/my_bookings_tile.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/my-bookings';

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('userData')
              .doc('bookings')
              .collection(uid)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (ctx, index) => MyBookingsTile(
                  booking: RequestModel.fromJson(
                      docs[index].data() as Map<String, dynamic>)),
              itemCount: docs.length,
            );
          },
        ));
  }
}
