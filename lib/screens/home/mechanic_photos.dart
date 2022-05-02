import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';

class MechanicPhotos extends StatelessWidget {
  MechanicPhotos(this.pictures, {Key? key}) : super(key: key);
  List<dynamic> pictures;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      children: pictures
          .map((e) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: AspectRatio(
                aspectRatio: 16 / 7,
                child: cachedImage(
                  e,
                  fit: BoxFit.cover,
                ),
              )))
          .toList(),
    );
  }
}
