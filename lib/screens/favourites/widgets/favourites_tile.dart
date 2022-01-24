import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/screens/my_boookings/my_booking_details.dart';

class FavouritesTile extends StatelessWidget {
  const FavouritesTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const MyBookingDetails());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2.5,
              child: Image.network(
                'https://www.kenyans.co.ke/files/styles/article_style/public/images/media/Mechanic.jpg?itok=-c2o5ygc',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Best Mechanic',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kileleshwa, Kenya',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
