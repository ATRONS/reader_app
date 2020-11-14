import 'package:flutter/material.dart';
import './book_card.dart';
import '../theme/app_theme.dart';
import '../utils/router.dart';
import '../views/genres/genre.dart';

class Booktab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSectionTitle('Genres'),
        SizedBox(height: 10.0),
        _buildGenreSection(),
        SizedBox(height: 20.0),
        _buildNewSection(),
        SizedBox(height: 10.0),
      ],
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
          Text(
            'See All',
            style: TextStyle(
              color: CustomTheme.lightAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
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
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            // Link link = homeProvider.top.feed.link[index];

            // We don't need the tags from 0-9 because
            // they are not categories

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
                    MyRouter.pushPage(
                      context,
                      Genre(title: 'Fiction'),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Biography',
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
                color: CustomTheme.lightAccent,
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
}
