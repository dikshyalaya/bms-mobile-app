import 'dart:developer';

import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/service/generate_fcm_token.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beacon_flutter/constants/enums.dart';

class CustomLoginButton extends StatefulWidget {
  const CustomLoginButton({
    Key? key,
    required this.userName,
    required this.password,
  }) : super(key: key);

  final TextEditingController userName;
  final TextEditingController password;

  @override
  State<CustomLoginButton> createState() => _CustomLoginButtonState();
}

class _CustomLoginButtonState extends State<CustomLoginButton> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (widget.userName.text.isEmpty || widget.password.text.isEmpty) {
      final errorMessage = widget.userName.text.isEmpty
          ? "Username is Required."
          : "Password is Required.";
      DialogueUtils.popUpMessageDialogue(
        // ignore: use_build_context_synchronously
        context: context,
        message: errorMessage,
        popUpType: PopUpType.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      FocusScope.of(context).unfocus();
      var fcm = await generateFCMToken();
      DateTime startTime = DateTime.now();
      await authProvider.login(
        // ignore: use_build_context_synchronously
        context,
        widget.userName.text,
        widget.password.text,
        fcm,
      );

      DateTime endTime = DateTime.now();

      Duration responseTime = endTime.difference(startTime);
      log('----- Login API response Time : ${responseTime.inSeconds} sec-----');
      // await authProvider.logIn(
      //   widget.userName.text,
      //   widget.password.text,
      //   fcm,
      //   onErrorState: (errorState) {
      //     print("has Error");
      //     shoErrorToast(errorState.message);
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   },
      //   onAccessToken: (Map<String, dynamic> onData) {
      //     if (onData['data'] != null) {
      //       final accessToken = onData["accessToken"];
      //       final email = onData['data']['email'];
      //       final isActive = onData['data']['isActive'];
      //       final userTypeId = onData['data']['userTypeId'];
      //       final empId = onData['data']['empId'];
      //       final empFirstName = onData['data']['employee']['empFirstName'];
      //       final empLastName = onData['data']['employee']['empLastName'];
      //       final isPasswordUpdateRequired =
      //           onData['data']['isPasswordUpdateRequired'];
      //       authProvider.savedLoginInfo(
      //         accessToken,
      //         BmsUserModel(
      //           email: email,
      //           isActive: isActive,
      //           userTypeId: userTypeId,
      //           empFirstName: empFirstName,
      //           empLastName: empLastName,
      //           empId: empId,
      //           isPasswordUpdateRequired: isPasswordUpdateRequired,
      //         ),
      //       );

      //       if (userTypeId == 1) {
      //         if (isPasswordUpdateRequired == true) {
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ChangePasswordPage(
      //                 userTypeId: userTypeId as int,
      //               ),
      //             ),
      //             (route) => false,
      //           );
      //         } else {
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const DashBoardScreen()),
      //             (route) => false,
      //           );
      //         }
      //       } else if (userTypeId == 4) {
      //         if (isPasswordUpdateRequired == true) {
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ChangePasswordPage(
      //                 userTypeId: userTypeId as int,
      //               ),
      //             ),
      //             (route) => false,
      //           );
      //         } else {
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const ManagerDashBoardScreen()),
      //             (route) => false,
      //           );
      //         }
      //       } else {}
      //     } else {
      //       shoErrorToast(onData['message']);
      //     }
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   },
      // );
    } catch (e) {
      log("Error occurred: $e");
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ))
        : Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 104.w,
              child: CustomElevatedButton(
                onPressed: () => _login(context),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1870FF), // Start color
                    Color(0xFF2E5698), // End color
                  ],
                ),
                text1: 'Login',
                bdRadius: 20.r,
              ),
            ),
          );
  }
}
