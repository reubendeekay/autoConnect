import 'package:flutter/material.dart';
import 'package:mechanic/screens/home/widgets/top_search.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(15),
        child: const MapSearchWidget());
  }
}
