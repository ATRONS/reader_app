import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MaterialReview extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String comment;
  final int stars;

  MaterialReview({
    Key key,
    @required this.firstname,
    @required this.lastname,
    @required this.comment,
    @required this.stars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            firstname + " " + lastname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        addVerticalSpace(10),
        SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {},
            starCount: 5,
            rating: stars.toDouble(),
            size: 20.0,
            isReadOnly: true,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            color: Colors.green,
            borderColor: Colors.green,
            spacing: 0.0),
        addVerticalSpace(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            comment,
            style: TextStyle(fontSize: 13),
          ),
        ),
        addVerticalSpace(10)
      ],
    );
  }
}
