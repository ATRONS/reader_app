import 'package:flutter/material.dart';
// import './loading.dart';
// import 'package:flutter_ebook_app/models/category.dart';
// import 'package:flutter_ebook_app/util/router.dart';
// import 'package:uuid/uuid.dart';

// import '../views/details/details.dart';

class MaterialReview extends StatelessWidget {
//   final String img;
  final String username;
  final String comment;
//   final Entry entry;

  MaterialReview({
    Key key,
    @required this.username,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "@$username - ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Expanded(
            child: Text(
          " $comment",
          style: TextStyle(fontSize: 13),
        ))
      ],
    );
  }
}
