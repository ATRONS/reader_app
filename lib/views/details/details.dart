// import 'package:flutter/material.dart';

// class Details extends StatefulWidget {
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Details of Book"),),
//       body: Center(
//         child: Text("This is supposed to be the details page"),
//       ),
//     );
//   }
// }

import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../fragments/book_list_item.dart';

class Details extends StatefulWidget {
  Details({
    Key key,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Feather.share,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: <Widget>[
          SizedBox(height: 10.0),
          _buildImageTitleSection(),
          SizedBox(height: 30.0),
          _buildSectionTitle('Book Description'),
          _buildDivider(),
          SizedBox(height: 10.0),
          // DescriptionTextWidget(
          //   text: '${widget.entry.summary.t}',
          // ),
          SizedBox(height: 30.0),
          _buildSectionTitle('More from Author'),
          _buildDivider(),
          SizedBox(height: 10.0),
          _buildMoreBook(),
        ],
      ),
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.caption.color,
    );
  }

  _buildImageTitleSection() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/warandpeace.jpg',
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
                    'widget.entry.title.t.replaceAll',
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
                    'widget.entry.author.name.t',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                _buildCategory(context),
                Center(
                  child: Container(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: _buildDownloadReadButton(context),
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
      'More From Author',
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildMoreBook() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
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

  _openMaterial(BuildContext context) async {
    EpubViewer.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "androidBook",
      scrollDirection: EpubScrollDirection.HORIZONTAL,
      allowSharing: true,
      enableTts: false,
    );
    await EpubViewer.openAsset(
      'assets/epubs/crime.epub',
    );
  }

  _buildDownloadReadButton(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        await _openMaterial(context);
      },
      child: Text(
        'Download',
      ),
    );
  }
}

_buildCategory(BuildContext context) {
  return Container(
    height: 95.0,
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 210 / 80,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: Theme.of(context).accentColor,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  'cat.label',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
