import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites"),),
      body: Center(
        child: Text("This is supposed to be the fav page"),
      ),
    ); 
  }
}