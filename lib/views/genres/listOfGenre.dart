import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfGenre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaterialProvider>(context, listen: false);
    final generes = provider.generes;

    return Scaffold(
        appBar: AppBar(
          title: Text("Genres"),
        ),
        body: ListView(
          children: <Widget>[
            Divider(color: Colors.black38),
            SizedBox(
              height: 10,
            ),
            _buildGenreListSection(generes)
          ],
        ));
  }

  _buildGenreListSection(List<Genere> generes) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: generes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Text(generes[index].getGenereName(GenereLang.english)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ));
  }
}
