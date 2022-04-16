import 'package:flutter/material.dart';
import 'package:mechanic/screens/home/widgets/top_search.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 130,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: const MapSearchWidget());
  }
}
