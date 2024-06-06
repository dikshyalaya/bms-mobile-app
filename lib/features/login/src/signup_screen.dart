import 'package:beacon_flutter/constants/app_images.dart';
import 'package:beacon_flutter/features/get_device_size/get_device_size.dart';
import 'package:beacon_flutter/features/login/split_widgets/signup_form_widget.dart';
import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool isTabletDevice; // Initialize with a default value
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
            height: MediaQuery.sizeOf(context).height,
            width: isTabletDevice ? (300.w) : null,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Stack(
                    children: [
                      const SignupFormWidget(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
