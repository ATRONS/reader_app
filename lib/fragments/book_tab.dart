import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/styles.dart';
import 'package:atrons_mobile/views/genres/listOfGenre.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './book_card.dart';
import '../theme/app_theme.dart';
import '../utils/router.dart';
import '../utils/helper_funcs.dart';

class Booktab extends StatefulWidget {
  @override
  _BooktabState createState() => _BooktabState();
}

class _BooktabState extends State<Booktab> {
  @override
  void initState() {
    super.initState();
    Provider.of<MaterialProvider>(context, listen: false).loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaterialProvider>(context, listen: false);

    return Selector<MaterialProvider, LoadingState>(
      selector: (context, model) => model.initialDataLoadingState,
      builder: (context, state, child) {
        if (state == LoadingState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state == LoadingState.failed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Constants.loadingFailed),
                FlatButton(
                  onPressed: () {
                    provider.setInitialDataState(LoadingState.failed);
                    provider.loadInitialData();
                  },
                  child: Text(Constants.retry),
                ),
              ],
            ),
          );
        }
        return ListView(
          children: <Widget>[
            _buildSectionTitle(Constants.generes, context),
            addVerticalSpace(10.0),
            _buildGenreSection(provider.generes),
            addVerticalSpace(20.0),
            _buildNewSection(provider),
            addVerticalSpace(20.0),
          ],
        );
      },
    );
  }

  _buildSectionTitle(String title, BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: Style.blackTextH1,
          ),
          InkWell(
            onTap: () {
              MyRouter.pushPage(
                ctx,
                ListOfGenre(),
              );
            },
            child: Text(
              Constants.seeAll,
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
                    // MyRouter.pushPage(
                    //   context,
                    //   BooksInGenre(title: generes[index].name),
                    // );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        generes[index].getGenereName(GenereLang.english),
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

  _buildNewSection(MaterialProvider provider) {
    final generes = [];
    final List<List<MiniMaterial>> materials = [];

    provider.popular.forEach((key, value) {
      generes.add(key);
      materials.add(value);
    });

    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: provider.popular.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              _buildSectionHeader(
                  provider.getGenereName(generes[index], GenereLang.english)),
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
              style: Style.blackTextH2,
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
              Constants.seeAll,
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
