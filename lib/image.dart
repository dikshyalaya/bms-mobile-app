import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Page'),
        ),
        body: Center(
          child: Image.network(
            'https://api-beacon.dikshyalaya.com/api/User/GetProfilePic',
            height: 300,
            width: 300,
            headers: const {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxNTY2MCIsIkVtcGxveWVlSWQiOiIxNjUxMTgiLCJGdWxsTmFtZSI6IlRlbWl0b3BlIE9ndW5sYW5hIiwiVXNlck5hbWUiOiJ0ZXN0X3VzZXIyQGdtYWlsLmNvbSIsIkVtYWlsIjoidGVzdF9vZ3VubGFuYXRlbWl0b3BlMTExQGdtYWlsLmNvbSIsIlJvbGVJZCI6IjEiLCJSb2xlTmFtZSI6IkJlYWNvblVzZXIiLCJqdGkiOiJjOTAyZmY2OS04MTZmLTRhMzAtODIwYS01ODM5N2Q5ZGU5YzciLCJleHAiOjE3NDgwMTY3NjQsImlzcyI6IkJNU0F1dGhTZXJ2ZXIiLCJhdWQiOiJCTVNDbGllbnQifQ.5Jjk4_7wnoV-sAycT--6_4xDIp8B0dl6GRTnZ8tp75E',
            },
          ),
        ));
  }
}
