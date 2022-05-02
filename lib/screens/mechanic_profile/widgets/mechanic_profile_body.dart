import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/horizontal_tab.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/home/mechanic_photos.dart';
import 'package:mechanic/screens/home/service_tile.dart';
import 'package:mechanic/screens/mechanic_profile/mechanic_reviews.dart';
import 'package:mechanic/screens/mechanic_profile/widgets/mechanic_details_location.dart';

List<String> mechanicProfileTabs = [
  'Services',
  'Photos',
  'Reviews',
  'Location',
];

class MechanicProfileBody extends StatelessWidget {
  const MechanicProfileBody({Key? key, required this.mechanic})
      : super(key: key);
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                mechanic.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              InkWell(
                  onTap: () async {
                    bool? res = await FlutterPhoneDirectCaller.callNumber(
                        mechanic.phone!);

                    if (res == false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Oops could not make phone call'),
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blueGrey),
                    child: const Icon(
                      Icons.call,
                      size: 18,
                      color: Colors.white,
                    ),
                  )),
            ],
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
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (mechanic.analytics!.rating! /
                          mechanic.analytics!.ratingCount!)
                      .toStringAsFixed(1),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('(${mechanic.analytics!.ratingCount!} Reviews)'),
              ],
            ),
          ),
          openingHours(),
          const SizedBox(
            height: 5,
          ),
          about(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: size.height * .6,
            child: HorizontalTabView(
              contents: [
                ListView(
                  children: List.generate(
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
                ),
                MechanicPhotos(mechanic.images!),
                MechanicReviews(
                  mechanicId: mechanic.id!,
                ),
                MechanicDetailsLocation(
                  imageUrl: mechanic.profile,
                  location: LatLng(mechanic.location!.latitude,
                      mechanic.location!.longitude),
                ),
              ],
              initialIndex: 0,
              contentScrollAxis: Axis.horizontal,
              backgroundColor: Colors.grey.shade100,
              tabs: List.generate(
                mechanicProfileTabs.length,
                (index) => Tab(text: mechanicProfileTabs[index]),
              ),
            ),
          ),
          const SizedBox(
            height: 48,
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

  Widget about() {
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
