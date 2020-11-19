import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BookItem extends StatelessWidget {
  final String img;
  final String title;

  BookItem({Key key, @required this.img, @required this.title})
      : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: Image.asset(
                'assets/images/warandpeace.jpg',
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Hero(
            tag: titleTag,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                '${title.replaceAll(r'\', '')}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
