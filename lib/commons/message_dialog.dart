/* By Abdullah As-Sadeed */

import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:flutter/material.dart';

void showMessageDialog(
  String title,
  String message, {
  void Function()? onOK,
}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onOK != null) {
                onOK();
              }

              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(navigatorKey.currentContext!)!.ok),
          ),
        ],
      );
    },
  );
}
