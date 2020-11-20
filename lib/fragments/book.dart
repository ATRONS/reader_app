import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BookItem extends StatelessWidget {
  final MiniMaterial materialobj;

  BookItem({
    Key key,
    @required this.materialobj,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    final matProvider = Provider.of<MaterialProvider>(context, listen: false);

    return InkWell(
      onTap: () => matProvider.openMaterial(context, materialobj.iD),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: Image.asset(
                // materialobj.coverImgUrl,
                'assets/images/warandpeace.jpg',
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Hero(
            tag: titleTag,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                '${materialobj.title.replaceAll(r'\', '')}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openMaterial(BuildContext context, String url) async {
    EpubViewer.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "androidBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: false,
      enableTts: false,
    );
    EpubViewer.open(url);
  }
}
