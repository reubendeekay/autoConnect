import 'package:flutter/material.dart';

class TopSearch extends StatefulWidget {
  const TopSearch({Key? key, this.onSearch}) : super(key: key);
  final Function(String searchText)? onSearch;

  @override
  State<TopSearch> createState() => _TopSearchState();
}

class _TopSearchState extends State<TopSearch> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Search Mechanics",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueGrey[50],
            ),
            child: TextFormField(
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (String value) {
                if (_formKey.currentState!.validate()) {
                  widget.onSearch!(value);
                }
              },
          
              decoration: InputDecoration(
                hintText: 'Search by name or location',
                hintStyle: const TextStyle(fontSize: 14),
                fillColor: Colors.blueGrey[50],
                filled: true,
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
