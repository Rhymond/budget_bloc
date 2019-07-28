import 'package:flutter/material.dart';
import 'package:todo/models/models.dart';

class DeleteExpenseSnackBar extends SnackBar {
  DeleteExpenseSnackBar({
    Key key,
    @required Expense expense,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'deleted "${expense.name}"',
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
