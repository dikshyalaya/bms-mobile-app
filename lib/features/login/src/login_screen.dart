// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:beacon_flutter/constants/app_images.dart';
import 'package:beacon_flutter/features/get_device_size/get_device_size.dart';
import 'package:beacon_flutter/features/login/split_widgets/login_form_widget.dart';
import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // checkDevice();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    checkDevice();
    });
  }

  checkDevice() {
    bool value = isTablet(context);
    storeBool('isTablet', value);
    setState(() {
      isTabletDevice = value;
    });
  }

  late bool isTabletDevice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Colors.grey,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003792), // Top part color
              Color(0xFF3E65A5), // Bottom part color
            ],
          ),
        ),
        child: Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.5,
            width: isTabletDevice? (300.w ):null,
            child: Stack(
              children: [
                const LoginFormWidget(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 107.h,
                    width: 107.w,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void shoErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message, backgroundColor: Colors.red, textColor: Colors.white);
}
