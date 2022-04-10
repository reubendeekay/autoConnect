import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/screens/mechanic/manage_bookings/widgets/admin_booking_details.dart';

class ManageBookingsTile extends StatelessWidget {
  const ManageBookingsTile({Key? key, required this.booking}) : super(key: key);

  final RequestModel booking;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        backgroundImage: CachedNetworkImageProvider(booking.user!.imageUrl!),
      ),
      title: Text(booking.services!.first.serviceName!),
      subtitle: Text('By ' + booking.user!.fullName!),
      // trailing: const Text(booking),
      onTap: () {
        Get.to(() => AdminBookingDetails(booking: booking));
      },
    );
  }
}
