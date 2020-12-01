import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:atrons_mobile/utils/styles.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fragments/book_list_item.dart';
import '../../fragments/descriptionTextWidget.dart';
import '../../fragments/review_body.dart';

class Details extends StatefulWidget {
  final String id;
  Details({Key key, @required this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isDownloaded = false;

  @override
  void initState() {
    Provider.of<DetailProvider>(context, listen: false)
        .getMaterialDetail(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final provider = Provider.of<DetailProvider>(context, listen: false);
        provider.setLoadingState(LoadingState.failed);
        provider.setIsDownloaded(false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
            ],
          ),
          body: Selector<DetailProvider, LoadingState>(
              selector: (context, model) => model.loadingState,
              builder: (context, state, child) {
                if (state == LoadingState.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state == LoadingState.failed) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Constants.errMsg1),
                        FlatButton(
                          onPressed: () {},
                          child: Text(Constants.retry),
                        )
                      ],
                    ),
                  );
                }

                final detail =
                    Provider.of<DetailProvider>(context, listen: false)
                        .selectedMaterial;
                return _buildDetailView(detail);
              })),
    );
  }

  Widget _buildDetailView(MaterialDetail detail) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        SizedBox(height: 10.0),
        _buildImageTitleSection(detail),
        SizedBox(height: 30.0),
        _buildSectionTitle('Synopsis'),
        _buildDivider(),
        SizedBox(height: 10.0),
        DescriptionTextWidget(text: detail.synopsis),
        SizedBox(height: 30.0),
        _buildSectionTitle('Tags'),
        SizedBox(
          height: 10.0,
        ),
        _buildTagsSection(),
        SizedBox(height: 30.0),
        _buildSectionTitleWithMore('More from Author'),
        _buildDivider(),
        SizedBox(height: 10.0),
        _buildMoreBook(),
        SizedBox(height: 30.0),
        _buildSectionTitleWithMore('Reviews'),
        _buildDivider(),
        SizedBox(height: 10.0),
        _buildSectionReview(),
      ],
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.caption.color,
    );
  }

  _buildImageTitleSection(MaterialDetail detail) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            detail.coverImgUrl,
            fit: BoxFit.cover,
            height: 200.0,
            width: 130.0,
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5.0),
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    detail.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 5.0),
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    detail.provider['display_name'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    '${Constants.rating} ${detail.rating['value']}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 10.0),
                Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Constants.sellingPrice,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        maxLines: 3,
                      ),
                      Text(
                        '${detail.price['selling']} ${Constants.currency}',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Constants.rentPrice,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        maxLines: 3,
                      ),
                      Text(
                        '${detail.price['rent']['value']} ${Constants.rentPer}',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    color: Theme.of(context).accentColor,
                    width: MediaQuery.of(context).size.width,
                    child: Selector<DetailProvider, bool>(
                      selector: (ctx, model) => model.isDownloaded,
                      builder: (context, isDownloaded, child) {
                        final materialProvider = Provider.of<MaterialProvider>(
                            context,
                            listen: false);

                        final openMaterialBtn = FlatButton(
                          padding: const EdgeInsets.all(15),
                          onPressed: () => materialProvider.openMaterial(
                              context, detailProvider.selectedMaterial.id),
                          child: Text(
                            Constants.open,
                            style: Style.whiteText,
                          ),
                        );

                        final downloadBtn = FlatButton(
                          onPressed: () => detailProvider.downloadFile(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              Constants.buyRent,
                              style: Style.whiteText,
                            ),
                          ),
                        );

                        if (!isDownloaded) {
                          return FutureBuilder(
                              future: fileExistsInAppDir(
                                  detailProvider.selectedMaterial.id),
                              builder: (ctx, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.data) return openMaterialBtn;
                                return downloadBtn;
                              });
                        }
                        return openMaterialBtn;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildSectionTitleWithMore(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$title',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'More',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _buildTagsSection() {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            // Link link = homeProvider.top.feed.link[index];

            // We don't need the tags from 0-9 because
            // they are not categories

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'fiction',
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

  _buildMoreBook() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: BookListItem(
            title: 'entry.title.t',
            author: 'entry.author.name.t',
            desc: 'this book describes about thee war on the 2nd and the',
          ),
        );
      },
    );
  }

  _buildSectionReview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: MaterialReview(
            username: "mek_user",
            comment:
                "great book. every single person should read this. a step forward to the future before everyone else ..",
          ),
        );
      },
    );
  }
}
