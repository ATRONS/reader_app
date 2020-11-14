import 'package:atrons_mobile/view_models/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book_tab.dart';
import '../../fragments/book_list_item.dart';
import '../../fragments/megazine_list_item.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {
  List<String> materials = ["Books", "Newspapers", "Megazines"];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<MaterialProvider>(context, listen: false).getInitialBookData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildSearchSection(),
      ),
      body: Selector<MaterialProvider, LoadingState>(
        selector: (context, model) => model.loadingState,
        builder: (context, state, child) {
          print(state);
          if (state == LoadingState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state == LoadingState.failed) {
            return Center(child: Text('Loading failed'));
          }

          return _buildBodyList();
        },
      ),
    );
  }

  Widget _buildBodyList() {
    return RefreshIndicator(
      // ignore: missing_return
      onRefresh: () {},
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          _buildMaterialSection(),
          SizedBox(height: 10.0),
          Divider(color: Colors.black38),
          SizedBox(height: 10.0),
          if (selectedIndex == 0) Booktab(),
          if (selectedIndex == 1) _buildNewsPaperTab(),
          if (selectedIndex == 2) _buildMegazineTab(),
        ],
      ),
    );
  }

  _buildSearchSection() {
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Center(
          child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(6.0),
            ),
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          filled: true,
          contentPadding: EdgeInsets.only(top: 3, left: 5),
          hintText: 'search',
        ),
      )),
    );
  }

  _buildMaterialSection() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: materials.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildMaterialBody(index)),
        ));
  }

  _buildMaterialBody(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                materials[index],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(top: 5 / 4),
                height: 2,
                width: 30,
                color:
                    selectedIndex == index ? Colors.black : Colors.transparent,
              )
            ],
          )),
    );
  }

  _buildNewsPaperTab() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: BookListItem(
                title: 'entry.title.t',
                author: 'entry.author.name.t',
                desc:
                    'this book nd and the describes about thee war on the 2nd and th',
              ),
            );
          },
        ));
  }

  _buildMegazineTab() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: MegazineListItem(
                title: 'entry.title.t',
                edition: 'entry.author.name.t',
                desc:
                    'this the megazine describes about  megazine describes about thee on the 2nd and the  describes about thee on the 2nd and the',
              ),
            );
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
