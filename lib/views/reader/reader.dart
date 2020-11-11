import 'package:flutter/material.dart';

class Reader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is supposed to be the fav page"),
      ),
    ); 
  }
}
  // openBook(DetailsProvider provider) async {
  //   List dlList = await provider.getDownload();
  //   if (dlList.isNotEmpty) {
  //     // dlList is a list of the downloads relating to this Book's id.
  //     // The list will only contain one item since we can only
  //     // download a book once. Then we use `dlList[0]` to choose the
  //     // first value from the string as out local book path
  //     Map dl = dlList[0];
  //     String path = dl['path'];

  //     List locators =
  //         await LocatorDB().getLocator(widget.entry.id.t.toString());

  //     EpubViewer.setConfig(
  //       identifier: 'androidBook',
  //       themeColor: Theme.of(context).accentColor,
  //       scrollDirection: EpubScrollDirection.VERTICAL,
  //       enableTts: false,
  //       allowSharing: true,
  //     );
  //     EpubViewer.open(path,
  //         lastLocation:
  //             locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null);
  //     EpubViewer.locatorStream.listen((event) async {
  //       // Get locator here
  //       Map json = jsonDecode(event);
  //       json['bookId'] = widget.entry.id.t.toString();
  //       // Save locator to your database
  //       await LocatorDB().update(json);
  //     });
  //   }
  // }

