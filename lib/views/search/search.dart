import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/details/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<MiniMaterial> searchResult = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "search",
              hintStyle: TextStyle(color: Colors.grey)),
          onChanged: (value) async {
            if (value.length > 2) {
              final incomingSearchResult =
                  await Provider.of<MaterialProvider>(context, listen: false)
                      .searchMaterial(value);
              setState(() {
                searchResult = incomingSearchResult;
              });
            }
          },
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: searchResult.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  MyRouter.pushPage(
                      context, Details(id: searchResult[index].id));
                },
                leading: Container(
                  height: 50,
                  child: Image.network(
                    searchResult[index].coverImgUrl,
                  ),
                ),
                title: Text(searchResult[index].title),
                trailing: Text(searchResult[index].type),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          )),
    );
  }
}
