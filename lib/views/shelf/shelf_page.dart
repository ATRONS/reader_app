import 'package:flutter/material.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book.dart';
// import '../../fragments/loading.dart';
// import '../../utils/router.dart';
// import 'package:provider/provider.dart';

class ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() => _ShelfPageState();
  Function navigateToStore;

  ShelfPage(Function navigationTapped) {
    navigateToStore = navigationTapped;
  }
}

class _ShelfPageState extends State<ShelfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Atrons',
        ),
      ),
      body: BodyBuilder(
        child: ListView(
          children: <Widget>[_buildCurrentMaterial(), _buildBodyList()],
        ),
      ),
    );
  }

  _buildCurrentMaterial() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          // current book in use
          child: BookItem(
            img: "kebede",
            title: "",
          ),
        ),
        Container(
            height: 100,
            width: 230,
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  child: Text(
                    "War and Peace by Leo Tolstoy",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                ),
                Container(
                  width: 230,
                  height: 3,
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.blue[100],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  _buildBodyList() {
    return GridView.builder(
      physics: new NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 200 / 340,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == 5) {
          return InkWell(
            onTap: () {
              widget.navigateToStore(1);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(
                Icons.add,
                color: Colors.grey,
                size: 100.0,
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: BookItem(
              img: "kebede",
              title: "war and peace",
            ),
          );
        }
      },
    );
  }
}
