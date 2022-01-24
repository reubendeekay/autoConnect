import 'package:flutter/material.dart';
import 'package:mechanic/screens/favourites/widgets/favourites_tile.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);
  static const routeName = '/my-favourites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favourites',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.5,
          backgroundColor: Colors.grey[50],
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        ),
        body: ListView(
          children: const [
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
            FavouritesTile(),
          ],
        ));
  }
}
