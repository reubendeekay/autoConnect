import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/screens/home/widgets/top_search.dart';
import 'package:mechanic/screens/notifications/notifications_screen.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.menu,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const NotificationsScreen());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.notifications,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const MapSearchWidget()
        ],
      ),
    );
  }
}
