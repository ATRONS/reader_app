import 'package:atrons_mobile/fragments/rate_material.dart';
import 'package:atrons_mobile/models/genere.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/models/review.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/utils/file_helper.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/utils/styles.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/views/purchase/purchase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
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
        addVerticalSpace(10),
        _buildImageTitleSection(detail),
        addVerticalSpace(30),
        _buildSectionTitle('Synopsis'),
        _buildDivider(),
        addVerticalSpace(10),
        DescriptionTextWidget(text: detail.synopsis),
        _buildTagsSection(detail.tags),
        _buildMoreBook(detail.moreFromAuthor),
        _buildRateThis(detail.reviews, detail.readersLastRating),
        _buildSectionReview(detail.reviews),
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
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Image.network(
              detail.coverImgUrl,
              fit: BoxFit.cover,
              height: 200.0,
              width: 130.0,
            ),
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
                          onPressed: () {
                            MyRouter.pushPage(context, Purchase());
                          },
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

  _buildTagsSection(List<Genere> taglist) {
    return taglist.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(30),
              _buildSectionTitle('Tags'),
              addVerticalSpace(10),
              Container(
                height: 50.0,
                child: ListView.builder(
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: taglist.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                taglist[index].name,
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
            ],
          );
  }

  _buildMoreBook(List<MiniMaterial> morefromprovider) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    return morefromprovider.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              addVerticalSpace(30),
              _buildSectionTitleWithMore('More from Author'),
              _buildDivider(),
              addVerticalSpace(10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: morefromprovider.length,
                itemBuilder: (BuildContext context, int index) {
                  final morematerial = morefromprovider[index];
                  return InkWell(
                    onTap: () {
                      MyRouter.pushPage(
                          context, Details(id: morefromprovider[index].id));
                      detailProvider.setLoadingState(LoadingState.loading);
                      detailProvider.setIsDownloaded(false);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: BookListItem(
                        title: morematerial.title,
                        author: morematerial.provider['display_name'],
                        desc:
                            'this book describes about thee war on the 2nd and the',
                        coverImg: morematerial.coverImgUrl,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }

  _buildRateThis(List<Review> comments, Map<String, dynamic> myrating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        addVerticalSpace(30),
        _buildSectionTitle('Rate this'),
        _buildDivider(),
        addVerticalSpace(10),
        SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {
              MyRouter.pushPage(
                  context, RatePage(comments: comments, lastrate: myrating));
            },
            starCount: 5,
            rating: myrating == null ? 0 : myrating['value'].toDouble(),
            size: 40.0,
            isReadOnly: false,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            color: Colors.green,
            borderColor: Colors.green,
            spacing: 0.0),
      ],
    );
  }

  _buildSectionReview(List<Review> comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        addVerticalSpace(30),
        _buildSectionTitleWithMore('Reviews'),
        _buildDivider(),
        addVerticalSpace(10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: MaterialReview(
                  firstname: comments[index].username['firstname'],
                  lastname: comments[index].username['lastname'],
                  comment: comments[index].comment,
                  stars: comments[index].starvalue),
            );
          },
        ),
      ],
    );
  }
}
