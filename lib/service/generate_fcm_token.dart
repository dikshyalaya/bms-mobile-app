import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> generateFCMToken() async {
 
    // Get the Firebase Messaging instance.
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get the FCM device token.
    String? token = await messaging.getToken();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // userLogin.collection('fcm_tokens').add({
    //   'created_at': DateTime.now(),
    //   'device_type': 'Android',
    //   'fcm_token': token
    // });

    // Return the FCM device token.
    print(token);
    log("FCM TOKEN: ${token}");
    if (token != null) {
      return token;
    } else {
      return '';
    }
}