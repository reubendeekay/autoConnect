import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/home/mechanic_photos.dart';
import 'package:mechanic/screens/mechanic/service_tile.dart';
import 'package:mechanic/screens/mechanic_profile/widgets/mechanic_details_location.dart';

class MechanicProfileBody extends StatelessWidget {
  const MechanicProfileBody({Key? key, required this.mechanic})
      : super(key: key);
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mechanic.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: kTextColor,
                size: 16,
              ),
              const SizedBox(width: 2.5),
              Text(
                mechanic.address!,
                style: TextStyle(color: kTextColor),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Text('4.5'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('(12 Reviews)'),
              ],
            ),
          ),
          openingHours(),
          services(),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          ...List.generate(
            mechanic.services!.length,
            (index) {
              return IgnorePointer(
                ignoring: true,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ServiceTile(
                    mechanic.services![index],
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'More Photos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          MechanicPhotos(mechanic.images!),
          const SizedBox(
            height: 10,
          ),
          MechanicDetailsLocation(
            imageUrl: mechanic.profile,
            location: LatLng(
                mechanic.location!.latitude, mechanic.location!.longitude),
          ),
          const SizedBox(
            height: 65,
          ),
        ],
      ),
    );
  }

  Widget openingHours() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Opening Hours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 2.5,
          ),
          Text(
            'Open now(${mechanic.openingTime} - ${mechanic.closingTime})',
            style: const TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }

  Widget services() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            mechanic.description!,
          ),
        ],
      ),
    );
  }
}
