import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseHeading extends StatelessWidget {
  final String heading;

  ExpenseHeading({
    Key key,
    @required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Hero(
          tag: '${heading}__heroTitle',
          child: Container(
            child: Text(
              heading,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Colors.grey[200]),
        ),
      ),
    );
  }
}
