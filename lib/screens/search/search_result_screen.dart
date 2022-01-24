import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mechanic/helpers/chat_tile_shimmer.dart';
import 'package:mechanic/models/mechanic_model.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:mechanic/screens/search/search_result_tile.dart';
import 'package:mechanic/screens/search/top_search.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key, required this.search}) : super(key: key);
  final String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopSearch(
            onSearch: (val) {
              Get.off(() => SearchResultScreen(search: val));
            },
          ),
          Expanded(
            child: FutureBuilder<List<MechanicModel>>(
                future: Provider.of<MechanicProvider>(context, listen: false)
                    .searchMechanic(search),
                builder: (ctx, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children:
                          List.generate(12, (index) => const ChatTileShimmer()),
                    );
                  }

                  return ListView(
                    padding: EdgeInsets.zero,
                    children: List.generate(data.data!.length,
                        (index) => SearchResultTile(data.data![index])),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
