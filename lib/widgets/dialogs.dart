import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showDialogInfo(BuildContext context, String title, String text) {
  final Widget okButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text("OK"),
  );

  final Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text("Отмена"),
  );

  final AlertDialog alert = AlertDialog(
    title: Text(title),
    backgroundColor: Theme.of(context).colorScheme.surface,
    content: Text(text),
    actions: [okButton, cancelButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
