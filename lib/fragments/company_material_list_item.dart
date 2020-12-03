import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/companyMaterials/company_material_view.dart';
import 'package:flutter/material.dart';

class CompanyMaterialListItem extends StatelessWidget {
  final MiniCompanyMaterial materialItem;

  CompanyMaterialListItem({
    Key key,
    @required this.materialItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.pushPage(context,
            CompanyMaterialView(materialItem.id, materialItem.displayName));
      },
      child: Container(
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
                  materialItem.avatarUrl,
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
                      materialItem.displayName,
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
                      materialItem.legalName,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${materialItem.about.length < 100 ? materialItem.about : materialItem.about.substring(0, 100)}...'
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
      ),
    );
  }
}
