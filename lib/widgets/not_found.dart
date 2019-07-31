import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  NotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("List is empty. Please add something"),
      ),
    );
  }
}
