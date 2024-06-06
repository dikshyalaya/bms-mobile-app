
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:beacon_flutter/constants/enums.dart';

class CustomSignupButton extends StatefulWidget {
  const CustomSignupButton({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  }) : super(key: key);

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  State<CustomSignupButton> createState() => _CustomSignupButtonState();
}

class _CustomSignupButtonState extends State<CustomSignupButton> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signup(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (widget.firstName.text.isEmpty ||
        widget.lastName.text.isEmpty ||
        widget.email.text.isEmpty ||
        widget.password.text.isEmpty ||
        widget.confirmPassword.text.isEmpty) {
      DialogueUtils.popUpMessageDialogue(
        // ignore: use_build_context_synchronously
        context: context,
        message: "All Fields Are required",
        popUpType: PopUpType.error,
      );
      return;
    } else if (widget.password.text != widget.confirmPassword.text) {
      DialogueUtils.popUpMessageDialogue(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Password and Confirm Password should be same",
        popUpType: PopUpType.error,
      );
      return;
    } else if (authProvider.isAgreeTerms == false) {
      DialogueUtils.popUpMessageDialogue(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Please agree to the terms and conditions",
        popUpType: PopUpType.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      FocusScope.of(context).unfocus();
      await authProvider.signUp(
        // ignore: use_build_context_synchronously
        context,
        widget.firstName.text,
        widget.lastName.text,
        widget.email.text,
        widget.password.text,
      );
    } catch (e) {
      DialogueUtils.popUpMessageDialogue(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Something went wrong.",
        popUpType: PopUpType.error,
      );
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
                onPressed: () => _signup(context),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1870FF), // Start color
                    Color(0xFF2E5698), // End color
                  ],
                ),
                text1: 'Signup',
                bdRadius: 20.r,
              ),
            ),
          );
  }
}
