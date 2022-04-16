import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/home/mechanic_photos.dart';
import 'package:mechanic/screens/home/widgets/request_service_button.dart';
import 'package:mechanic/screens/mechanic/service_tile.dart';
import 'package:mechanic/screens/mechanic_profile/mechanic_profile_screen.dart';

class SelectedMechanicWidget extends StatelessWidget {
  const SelectedMechanicWidget(
      {Key? key, required this.mechanic, this.controller})
      : super(key: key);
  final ScrollController? controller;
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView(
        controller: controller,
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => MechanicProfileScreen(mechanic: mechanic));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        CachedNetworkImageProvider(mechanic.profile!),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nearby you',
                            style: TextStyle(color: kTextColor, fontSize: 12),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: kTextColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            mechanic.address!,
                            style: TextStyle(color: kTextColor, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(mechanic.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const Spacer(),
                  RaisedButton(
                    onPressed: () {
                      Get.to(() => MechanicProfileScreen(mechanic: mechanic));
                    },
                    child: const Text(
                      'View Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kPrimaryColor,
                  )
                ],
              ),
            ),
          ),
          openingHours(),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          // MechanicPhotos(mechanic.images!),
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
        ],
      ),
    );
  }

  Widget openingHours() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Opening Hours',
            style: TextStyle(fontWeight: FontWeight.w500),
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
}

class SelectedMechanicPrompt extends StatelessWidget {
  const SelectedMechanicPrompt({
    Key? key,
    required this.mechanic,
  }) : super(key: key);
  final MechanicModel mechanic;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: 0.8,
              minChildSize: 0.2,
              builder: (ctx, controller) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: SelectedMechanicWidget(
                      controller: controller,
                      mechanic: mechanic,
                    )),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: RequestServiceButton(
              mechanic: mechanic,
            ))
      ],
    );
  }
}
