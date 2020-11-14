import 'package:flutter/material.dart';
import '../../fragments/book.dart';

class Genre extends StatelessWidget {
  final String title;

  Genre({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 200 / 340,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: BookItem(
              img: "kebede",
              title: "war and peace",
            ),
          );
        },
      ),
    );
  }
}
