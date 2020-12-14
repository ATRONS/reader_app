import 'package:flutter/material.dart';
// import './loading.dart';
// import 'package:flutter_ebook_app/models/category.dart';
// import 'package:flutter_ebook_app/util/router.dart';
import 'package:uuid/uuid.dart';

// import '../views/details/details.dart';

class BookListItem extends StatelessWidget {
//   final String img;
  final String title, author, desc, coverImg;
//   final Entry entry;

  BookListItem(
      {Key key,
      @required this.title,
      @required this.author,
      @required this.desc,
      @required this.coverImg})
      : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            elevation: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              child: Image.network(
                coverImg,
                fit: BoxFit.cover,
                height: 150.0,
                width: 100.0,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    author,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${desc.length < 100 ? desc : desc.substring(0, 100)}'
                      .replaceAll(r'\n', '\n')
                      .replaceAll(r'\r', '')
                      .replaceAll(r'\"', '"'),
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
