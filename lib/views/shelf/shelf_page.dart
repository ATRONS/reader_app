import 'package:flutter/material.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book_card.dart';
// import '../../fragments/loading.dart';
// import '../../utils/router.dart';
// import 'package:provider/provider.dart';

class ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() => _ShelfPageState();
}

class _ShelfPageState extends State<ShelfPage> {

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Atrons',
            ),
          ),
          body: BodyBuilder(
            child: _buildBodyList(),
          ),
        );
  }

  _buildBodyList() {
    return ListView.builder(
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
              'Fiction',
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
          ); }
  }