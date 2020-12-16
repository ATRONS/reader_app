import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasedPage extends StatefulWidget {
  @override
  _PurchasedPageState createState() => _PurchasedPageState();
}

class _PurchasedPageState extends State<PurchasedPage> {
  List<MaterialDetail> purchasedList = [];
  LoadingState state = LoadingState.failed;

  @override
  void initState() {
    _loadOwnedMaterials();
    super.initState();
  }

  _loadOwnedMaterials() {
    setState(() {
      state = LoadingState.loading;
    });
    Provider.of<MaterialProvider>(context, listen: false)
        .ownedMaterialsRequest()
        .then((value) {
      purchasedList = value;
      print(value.length);
      setState(() {
        state = LoadingState.success;
      });
    }).catchError((err) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildReloadButton() {
    return Center(
      child: Column(
        children: [
          Text('Loading failed'),
          addVerticalSpace(10),
          FlatButton(
            onPressed: _loadOwnedMaterials,
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
    return Center(child: Text('You do not own any materials yet'));
  }

  @override
  Widget build(BuildContext context) {
    final materialProvider =
        Provider.of<MaterialProvider>(context, listen: false);
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text("Purchased Materials"),
        ),
        body: state == LoadingState.failed
            ? _buildReloadButton()
            : state == LoadingState.loading
                ? _buildLoading()
                : purchasedList.length == 0
                    ? _buildEmptyMessage()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: purchasedList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final material = purchasedList[index];
                            final secondRowTxt = material.type == 'BOOK'
                                ? "Book"
                                : '${material.edition}';

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 5),
                                      height: 80,
                                      width: 60,
                                      child:
                                          Image.network(material.coverImgUrl),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(material.title,
                                            textAlign: TextAlign.left),
                                        Text(secondRowTxt,
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                    future: fileExistsInAppDir(material.id),
                                    builder: (ctx, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.data) {
                                        return Container(
                                          margin: EdgeInsets.only(left: 10),
                                          height: 40,
                                          color: Theme.of(context).accentColor,
                                          child: FlatButton(
                                            onPressed: () {
                                              materialProvider.openMaterial(
                                                  context, material.id);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                "Open",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container(
                                        margin: EdgeInsets.only(left: 10),
                                        height: 40,
                                        color: Theme.of(context).accentColor,
                                        child: FlatButton(
                                          onPressed: () {
                                            detailProvider
                                                .setSelectedMaterial(material);
                                            detailProvider
                                                .downloadFile(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Text(
                                              "Download",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      ));
  }
}
