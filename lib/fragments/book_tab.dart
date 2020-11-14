import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/view_models/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './book_card.dart';
import '../theme/app_theme.dart';
import '../utils/router.dart';
import '../views/genres/genre.dart';

class Booktab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaterialProvider>(context, listen: false);
    final generes = provider.generes;
    final popular = provider.popular;

    return Column(
      children: <Widget>[
        _buildSectionTitle('Genres'),
        SizedBox(height: 10.0),
        _buildGenreSection(generes),
        SizedBox(height: 20.0),
        _buildNewSection(popular),
        SizedBox(height: 10.0),
      ],
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              color: CustomTheme.lightAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  _buildGenreSection(List<Genere> generes) {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: generes.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  onTap: () {
                    MyRouter.pushPage(
                      context,
                      Genre(title: generes[index].name),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        generes[index].name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildNewSection(Map<String, List<MiniMaterial>> popular) {
    final generes = [];
    final List<List<MiniMaterial>> materials = [];

    popular.forEach((key, value) {
      generes.add(key);
      materials.add(value);
    });

    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: popular.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              _buildSectionHeader(generes[index]),
              SizedBox(height: 10.0),
              _buildSectionBookList(materials[index]),
            ],
          ),
        );
      },
    );
  }

  _buildSectionHeader(String genereName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              'Popular of $genereName',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              //   MyRouter.pushPage(
              //     context,
              //     Genre(
              //       title: 'Crime and Punishment',
              //       url: 'www.google.com',
              //     ),
              //   );
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: CustomTheme.lightAccent,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionBookList(List<MiniMaterial> materials) {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: materials.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 10.0,
              ),
              child: BookCard(material: materials[index]),
            );
          },
        ),
      ),
    );
  }
}
