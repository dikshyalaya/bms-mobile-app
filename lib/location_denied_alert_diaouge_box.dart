import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> showLocationDeniedDialog(BuildContext context, String title, String body) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // Text('Cannot login without Location enabled'),
              Text(body),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();

              await Geolocator.openLocationSettings();
            },
          ),
        ],
      );
    },
  );
}
