import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:atrons_mobile/view_models/loading_state.dart';
import 'package:atrons_mobile/view_models/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    Provider.of<MaterialProvider>(context, listen: false).loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<MaterialProvider>(context, listen: false);

    final tabs = <Widget>[Booktab(), _buildNewsPaperTab(), _buildMegazineTab()];

    return RefreshIndicator(
      onRefresh: () async {
        provider.setInitialDataState(LoadingState.reloading);
        provider.loadInitialData();
      },
      child: Column(
        children: [
          _buildSearchSection(),
          addVerticalSpace(10.0),
          _buildMaterialSection(),
          addVerticalSpace(10.0),
          addDivider(Colors.black38),
          addVerticalSpace(10.0),
          Expanded(child: tabs[selectedIndex]),
        ],
      ),
    );
  }

  _buildSearchSection() {
    return GestureDetector(
      onTap: () {
        print('segue to the search page');
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
          child: Text(
            Constants.searchHint,
            style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
          ),
        ),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
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
              _buildMaterialBody(index),
        ),
      ),
    );
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
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
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
