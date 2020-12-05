import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchInputController = TextEditingController();

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: TextField(
          controller: searchInputController,
          autofocus: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "search",
              hintStyle: TextStyle(color: Colors.grey)),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
