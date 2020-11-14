import 'package:atrons_mobile/view_models/material_provider.dart';
import 'package:provider/provider.dart';

import './personal/personal_page.dart';
import 'shelf/shelf_page.dart';
import 'store/store_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            ShelfPage(navigationTapped),
            StorePage(),
            PersonalPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey[500],
          backgroundColor: Theme.of(context).primaryColor,
          onTap: navigationTapped,
          currentIndex: _page,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Feather.home),
              label: 'Shelf',
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.compass),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.settings),
              label: 'Personal',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
