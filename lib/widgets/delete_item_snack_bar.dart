import 'package:flutter/material.dart';
import 'package:todo/models/models.dart';

class DeleteItemSnackBar extends SnackBar {
  DeleteItemSnackBar({
    Key key,
    @required String name,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'deleted "$name"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'undo',
            onPressed: onUndo,
          ),
        );
}
