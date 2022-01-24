import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/screens/search/search_overview.dart';

class MapSearchWidget extends StatelessWidget {
  const MapSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const SearchOverview());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey[400],
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Type location or name',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
