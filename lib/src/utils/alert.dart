import 'package:flutter/cupertino.dart';

class Alert {

  static Future<bool?> showAlertDialog(BuildContext context) async {
    return await showCupertinoModalPopup<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Kamu Ingin Keluar?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}