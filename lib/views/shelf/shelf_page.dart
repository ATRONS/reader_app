import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book_card.dart';
import '../../fragments/book_list_item.dart';
// import '../../utils/router.dart';
// import 'package:flutter_ebook_app/view_models/home_provider.dart';
// import 'package:flutter_ebook_app/views/genre/genre.dart';
// import 'package:provider/provider.dart';

class ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> with AutomaticKeepAliveClientMixin {
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
            title: Text(
              'Atrons',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          body: _buildBody(),
        );
  }

  Widget _buildBody() {
    return BodyBuilder(
      child: _buildBodyList()
    );
  }

  Widget _buildBodyList() {
    return RefreshIndicator(
      onRefresh: () {},
      child: ListView(
        children: <Widget>[
          _buildFeaturedSection(),
          SizedBox(height: 20.0),
          _buildSectionTitle('Categories'),
          SizedBox(height: 10.0),
          _buildGenreSection(),
          SizedBox(height: 20.0),
          _buildSectionTitle('Recently Added'),
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

  _buildFeaturedSection() {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: BookCard(),
            );
          },
        ),
      ),
    );
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
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItem(
            title: 'war and peace',
            author: 'leo Tolstoy',
            desc: 'leo Tolstoys best book which by many athiest elites is known to be the book'
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
