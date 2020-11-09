import 'package:flutter/material.dart';
// import './loading_widget.dart';
import 'package:uuid/uuid.dart';

class BookCard extends StatelessWidget {
  BookCard({
    Key key
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 4.0,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: Image.asset(
                  'assets/images/warandpeace.jpg',
                  fit: BoxFit.cover,
                )
            ),
          ),
        ),
      ),
    );
  }
}
