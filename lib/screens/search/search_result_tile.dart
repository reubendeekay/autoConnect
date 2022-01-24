import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/mechanic_profile/mechanic_profile_screen.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile(this.mechanic, {Key? key}) : super(key: key);
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MechanicProfileScreen(mechanic: mechanic));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(mechanic.profile!),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mechanic.name!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  mechanic.address!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
