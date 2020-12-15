import 'package:atrons_mobile/fragments/book_card.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksInGenre extends StatefulWidget {
  final String title;
  final String genreid;
  BooksInGenre({@required this.title, @required this.genreid});

  @override
  _BooksInGenreState createState() => _BooksInGenreState();
}

class _BooksInGenreState extends State<BooksInGenre> {
  LoadingState state = LoadingState.failed;
  List<MiniMaterial> genreResult = [];

  @override
  void initState() {
    _loadBooksFromGenre(widget.genreid);
    super.initState();
  }

  _loadBooksFromGenre(String genreID) {
    setState(() {
      state = LoadingState.loading;
    });
    Provider.of<MaterialProvider>(context, listen: false)
        .findInGenre(genreID)
        .then((value) {
      genreResult = value;
      setState(() {
        state = LoadingState.success;
      });
    }).catchError((err) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }

  Widget _buildReloadButton() {
    return Center(
      child: Column(
        children: [
          Text('Loading failed'),
          addVerticalSpace(10),
          FlatButton(
            onPressed: _loadBooksFromGenre(widget.genreid),
            child: Text('Retry'),
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(child: Text('did not find books in genre'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: state == LoadingState.failed
          ? _buildReloadButton()
          : state == LoadingState.loading
              ? _buildLoading()
              : genreResult.length == 0
                  ? _buildEmptyMessage()
                  : GridView.builder(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                      shrinkWrap: true,
                      itemCount: genreResult.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 200 / 340,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 4),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child:
                                      BookCard(material: genreResult[index])),
                              Container(
                                  child: Text(
                                genreResult[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ))
                            ],
                          ),
                        );
                      },
                    ),
    );
  }
}
