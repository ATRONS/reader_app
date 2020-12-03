import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/details/details.dart';
import 'package:flutter/material.dart';

class CompanyMaterialCard extends StatelessWidget {
  final MiniMaterial minimaterial;

  CompanyMaterialCard({Key key, @required this.minimaterial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Card(
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
                MyRouter.pushPage(context, Details(id: minimaterial.id));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Image.network(
                  minimaterial.coverImgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          addVerticalSpace(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 0),
            child: Text(
              "Edition: ${minimaterial.edition}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
