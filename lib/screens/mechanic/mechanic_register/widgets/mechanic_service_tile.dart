import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';

class MechanicServiceTile extends StatelessWidget {
  const MechanicServiceTile({Key? key}) : super(key: key);

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
            child: Image.asset(
              'assets/images/mountains.jpg',
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
              children: const [
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Car Wash',
                  style: TextStyle(
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
                SizedBox(
                  height: 8,
                ),
                Text(
                  'KES 1200',
                  style: TextStyle(
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
                SizedBox(
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
