import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book_card.dart';
// import '../../fragments/book_list_item.dart';
// import '../../utils/router.dart';
// import 'package:flutter_ebook_app/view_models/home_provider.dart';
// import 'package:flutter_ebook_app/views/genre/genre.dart';
// import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {

  List<String> materials = ["Books","Newspapers","Megazines"];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback(
    //   (_) => Provider.of<HomeProvider>(context, listen: false).getFeeds(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _buildSearchSection(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BodyBuilder(child: _buildBodyList());
  }

  Widget _buildBodyList() {
    return RefreshIndicator(
      // ignore: missing_return
      onRefresh: () {},
      child: ListView(
        children: <Widget>[
          // _buildSearchSection(),
          SizedBox(height: 10.0),
          _buildMaterialSection(),
          SizedBox(height: 10.0),
          Divider(color: Colors.black38),
          SizedBox(height: 10.0),
          _buildSectionTitle('Generes'),
          SizedBox(height: 10.0),
          _buildGenreSection(),
          SizedBox(height: 20.0),
          _buildNewSection(),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
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
            contentPadding: EdgeInsets.only(top:3, left: 5),
            hintText: 'search',),
      )),
    );
  }

_buildMaterialSection(){
  return Padding(padding: EdgeInsets.symmetric(horizontal: 10)
  , child:SizedBox(
    height: 25,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: materials.length,
      itemBuilder:(BuildContext context, int index) => _buildMaterialBody(index)
    ),
  ));
}

_buildMaterialBody(int index){
  return Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Text(materials[index],
              style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5/4),
            height: 2,
            width: 30,
            color: selectedIndex == index ? Colors.black : Colors.transparent,
          )
      ],
    ));
}

  _buildGenreSection() {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: 14,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            // Link link = homeProvider.top.feed.link[index];

            // We don't need the tags from 0-9 because
            // they are not categories
            if (index < 10) {
              return SizedBox();
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  onTap: () {
                    // MyRouter.pushPage(
                    //   context,
                    //   Genre(
                    //     title: '${link.title}',
                    //     url: link.href,
                    //   ),
                    // );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'war and peace',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildNewSection() {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 13,
      itemBuilder: (BuildContext context, int index) {
        if (index < 10) {
          return SizedBox();
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              _buildSectionHeader(),
              SizedBox(height: 10.0),
              _buildSectionBookList(),
            ],
          ),
        );
      },
    );
  }

  _buildSectionHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              'Popular of Fiction',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              //   MyRouter.pushPage(
              //     context,
              //     Genre(
              //       title: 'Crime and Punishment',
              //       url: 'www.google.com',
              //     ),
              //   );
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionBookList() {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 10.0,
              ),
              child: BookCard(),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
