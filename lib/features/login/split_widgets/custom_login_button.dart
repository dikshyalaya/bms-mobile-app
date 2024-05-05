import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/service/generate_fcm_token.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      DialogueUtils.showErrorDialogue(
        context: context,
        message: errorMessage,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      FocusScope.of(context).unfocus();
      var fcm = await generateFCMToken();
      await authProvider.logIn(
        widget.userName.text,
        widget.password.text,
        fcm,
        onErrorState: (errorState) {
          print("has Error");
          setState(() {
            _isLoading = false;
          });
        },
        onAccessToken: (Map<String, dynamic> onData) {
          if (onData['data'] != null) {
            final accessToken = onData["accessToken"];
            final email = onData['data']['email'];
            final isActive = onData['data']['isActive'];
            final userTypeId = onData['data']['userTypeId'];
            final empId = onData['data']['empId'];
            final empFirstName = onData['data']['employee']['empFirstName'];
            final empLastName = onData['data']['employee']['empLastName'];
            authProvider.savedLoginInfo(
              accessToken,
              BmsUserModel(
                email: email,
                isActive: isActive,
                userTypeId: userTypeId,
                empFirstName: empFirstName,
                empLastName: empLastName,
                empId: empId,
              ),
            );

            if (userTypeId == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()),
                (route) => false,
              );
            } else if (userTypeId == 4) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManagerDashBoardScreen()),
                (route) => false,
              );
            } else {}
          } else {
            print("has error");
            shoErrorToast(onData['message']);
          }
          setState(() {
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      print("Error occurred: $e");
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
