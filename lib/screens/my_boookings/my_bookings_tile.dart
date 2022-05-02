import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/models/request_model.dart';
import 'package:mechanic/screens/my_boookings/my_booking_details.dart';

class MyBookingsTile extends StatelessWidget {
  const MyBookingsTile({Key? key, required this.booking}) : super(key: key);
  final RequestModel booking;

  Color color() {
    if (booking.status == 'ongoing') {
      return Colors.orange;
    } else if (booking.status == 'completed') {
      return Colors.green;
    } else if (booking.status == 'cancelled') {
      return Colors.grey;
    } else if (booking.status == 'pending') {
      return Colors.red;
    }

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MyBookingDetails(
              request: booking,
            ));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2.5,
                  child: cachedImage(
                    booking.services!.isEmpty
                        ? 'https://autogarageinc.com/wp-content/uploads/2020/03/Screenshot_3.jpg'
                        : booking.services!.first.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.mechanic!.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        booking.mechanic!.address!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            'Vehicle: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            booking.vehicleModel!,
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Date & Time: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            DateFormat('hh:mm a dd MMM yyyy')
                                .format(booking.date!),
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 5,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                color: color(),
                child: Text(
                  booking.status![0].toUpperCase() +
                      booking.status!.substring(1),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ))
        ],
      ),
    );
  }
}
