import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fragments/body_builder.dart';
import '../../fragments/book.dart';

class ShelfPage extends StatefulWidget {
  @override
  _ShelfPageState createState() => _ShelfPageState();
  final Function navigateToStore;

  ShelfPage({Key key, @required this.navigateToStore});
}

class _ShelfPageState extends State<ShelfPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaterialProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.getDownloadedMaterials(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return BodyBuilder(
          child: ListView(
            children: <Widget>[
              // _buildCurrentMaterial(),
              _buildBodyList(snapshot.data)
            ],
          ),
        );
      },
    );
  }

  _buildCurrentMaterial() {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 20.0),
            // current book in use
            child: Container()),
        Container(
            height: 100,
            width: 230,
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  child: Text(
                    "war is not and peace",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                ),
                Container(
                  width: 230,
                  height: 3,
                  padding: EdgeInsets.symmetric(horizontal: 5),
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

  _buildBodyList(List<MiniMaterial> shelfitems) {
    return GridView.builder(
      physics: new NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      shrinkWrap: true,
      itemCount: shelfitems.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 200 / 340,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == shelfitems.length) {
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
              materialobj: shelfitems[index],
            ),
          );
        }
      },
    );
  }
}
