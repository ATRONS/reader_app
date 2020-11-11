import 'package:flutter/material.dart';
import '../utils/router.dart';
// import './loading_widget.dart';
// import 'package:uuid/uuid.dart';
import '../views/details/details.dart';

class BookCard extends StatelessWidget {
  BookCard({
    Key key
  }) : super(key: key);

  // static final uuid = Uuid();


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
          onTap: () {
           MyRouter.pushPage(context, Details());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            
              child: Image.asset(
                  'assets/images/warandpeace.jpg',
                  fit: BoxFit.cover,
                )
            
          ),
        ),
      ),
    );
  }
}
