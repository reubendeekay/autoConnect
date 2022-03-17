import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/screens/home/mechanic_photos.dart';
import 'package:mechanic/screens/home/widgets/request_service_button.dart';
import 'package:mechanic/screens/mechanic_profile/mechanic_profile_screen.dart';

class SelectedMechanicWidget extends StatelessWidget {
  const SelectedMechanicWidget(
      {Key? key, required this.mechanic, this.controller})
      : super(key: key);
  final ScrollController? controller;
  final MechanicModel mechanic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView(
        controller: controller,
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
                  Column(
                    children: [
                      const Text('Ksh 3,000',
                          style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        'Average Price',
                        style: TextStyle(color: kTextColor, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                Text('(100 Reviews)'),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Featured Images',
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          MechanicPhotos(mechanic.images!),
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
              initialChildSize: 0.3,
              maxChildSize: 0.6,
              minChildSize: 0.17,
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
