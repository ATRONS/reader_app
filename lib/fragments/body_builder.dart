import 'package:flutter/material.dart';

class BodyBuilder extends StatelessWidget {
  final Widget child;

  BodyBuilder(
      {Key key,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
   return child;
  }
}
