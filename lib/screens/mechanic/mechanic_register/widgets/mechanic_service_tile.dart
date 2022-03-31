import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/service_model.dart';

class MechanicServiceTile extends StatelessWidget {
  const MechanicServiceTile({Key? key, required this.service})
      : super(key: key);

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // This clips the child            ),
            child: cachedImage(
              service.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        AspectRatio(
            aspectRatio: 1.3,
            child: Container(
              decoration: BoxDecoration(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
            )),
        AspectRatio(
          aspectRatio: 1.3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  service.serviceName!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'KES ${service.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
