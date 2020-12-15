// import 'package:atrons_mobile/models/material.dart';
// import 'package:atrons_mobile/providers/loading_state.dart';
// import 'package:atrons_mobile/providers/material_provider.dart';
// import 'package:atrons_mobile/utils/helper_funcs.dart';
// import 'package:atrons_mobile/utils/router.dart';
// import 'package:atrons_mobile/views/details/details.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Favorites extends StatefulWidget {
//   @override
//   _FavoritesState createState() => _FavoritesState();
// }

// class _FavoritesState extends State<Favorites> {
//   List<MiniMaterial> favoritesList = [];
//   LoadingState state = LoadingState.failed;

//   @override
//   void initState() {
//     // _loadFavoriteMaterials();
//     super.initState();
//   }

//   // _loadFavoriteMaterials() {
//   //   setState(() {
//   //     state = LoadingState.loading;
//   //   });
//   //   Provider.of<MaterialProvider>(context, listen: false)
//   //       .getWishListRequest()
//   //       .then((value) {
//   //     favoritesList = value;
//   //     print(value.length);
//   //     setState(() {
//   //       state = LoadingState.success;
//   //     });
//   //   }).catchError((err) {
//   //     setState(() {
//   //       state = LoadingState.failed;
//   //     });
//   //   });
//   // }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Widget _buildReloadButton() {
//     return Center(
//       child: Column(
//         children: [
//           Text('Loading failed'),
//           addVerticalSpace(10),
//           FlatButton(
//             onPressed: _loadFavoriteMaterials,
//             child: Text('Retry'),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildLoading() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget _buildEmptyMessage() {
//     return Center(child: Text('No favorites yet'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Favorites"),
//       ),
//       body: state == LoadingState.failed
//           ? _buildReloadButton()
//           : state == LoadingState.loading
//               ? _buildLoading()
//               : favoritesList.length == 0
//                   ? _buildEmptyMessage()
//                   : Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                       child: ListView.separated(
//                         shrinkWrap: true,
//                         itemCount: favoritesList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             onTap: () {
//                               MyRouter.pushPage(context,
//                                   Details(id: favoritesList[index].id));
//                             },
//                             leading: Container(
//                               height: 50,
//                               child: Image.network(
//                                 favoritesList[index].coverImgUrl,
//                               ),
//                             ),
//                             subtitle: favoritesList[index].type == "BOOK"
//                                 ? Text("")
//                                 : Text(
//                                     '${favoritesList[index].edition}th edition'),
//                             title: Text(favoritesList[index].title),
//                             trailing: Text(favoritesList[index].type),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) {
//                           return Divider();
//                         },
//                       )),
//     );
//   }
// }
