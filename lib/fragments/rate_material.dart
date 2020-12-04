import 'package:atrons_mobile/fragments/review_body.dart';
import 'package:atrons_mobile/models/review.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatePage extends StatelessWidget {
  final List<Review> comments;
  final Map<String, dynamic> lastrate;

  RatePage({@required this.comments, @required this.lastrate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "POST",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: SmoothStarRating(
                allowHalfRating: false,
                onRated: (v) {
                  // print(v);
                },
                starCount: 5,
                rating: 3,
                size: 50.0,
                isReadOnly: false,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                color: Colors.green,
                borderColor: Colors.green,
                spacing: 0.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3.0),
                ),
                hintText: 'Describe your experience (optional)',
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text("200 max.")),
          addVerticalSpace(10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                child: MaterialReview(
                    firstname: comments[index].username['firstname'],
                    lastname: comments[index].username['lastname'],
                    comment: comments[index].comment,
                    stars: comments[index].starvalue),
              );
            },
          ),
        ],
      ),
    );
  }
}
