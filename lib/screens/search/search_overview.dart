import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/search/search_result_screen.dart';
import 'package:mechanic/screens/search/search_result_tile.dart';
import 'package:mechanic/screens/search/top_search.dart';

class SearchOverview extends StatefulWidget {
  const SearchOverview({Key? key}) : super(key: key);

  @override
  State<SearchOverview> createState() => _SearchOverviewState();
}

class _SearchOverviewState extends State<SearchOverview> {
  @override
  Widget build(BuildContext context) {
    String search = '';
    return Scaffold(
      body: Column(
        children: [
          TopSearch(
            onSearch: (val) {
              setState(() {
                search = val;
              });
              Get.off(() => SearchResultScreen(search: search));
            },
          ),
        ],
      ),
    );
  }
}
