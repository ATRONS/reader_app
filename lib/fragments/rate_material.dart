import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating"),
      ),
      body: Center(
        child: SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {
              // print(v);
            },
            starCount: 5,
            rating: 3,
            size: 40.0,
            isReadOnly: false,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            color: Colors.green,
            borderColor: Colors.green,
            spacing: 0.0),
      ),
    );
  }
}
