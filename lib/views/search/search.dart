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
  bool typebook = false, typemagazine = false, typenewspaper = false;

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
                      .searchMaterial(
                          value, typebook, typemagazine, typenewspaper);
              setState(() {
                searchResult = incomingSearchResult;
              });
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              MyRouter.pushPageDialog(context, _buildSortItems(context));
            },
          )
        ],
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
                subtitle: searchResult[index].type == "BOOK"
                    ? Text("")
                    : Text('${searchResult[index].edition}th edition'),
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

  _buildSortItems(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Filter"),
              content: Container(
                  height: 180,
                  child: ListView(
                    children: [
                      CheckboxListTile(
                        title: Text("Book"),
                        value: typebook,
                        onChanged: (newValue) {
                          setState(() {
                            typebook = newValue;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Newspaper"),
                        value: typenewspaper,
                        onChanged: (newValue) {
                          setState(() {
                            typenewspaper = newValue;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Magazine"),
                        value: typemagazine,
                        onChanged: (newValue) {
                          setState(() {
                            typemagazine = newValue;
                          });
                        },
                      ),
                    ],
                  )),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        });
  }
}
