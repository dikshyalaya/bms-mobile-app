import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/constants/enums.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/get_device_size/get_device_size.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  final int userTypeId;
  const ChangePasswordPage({Key? key, required this.userTypeId})
      : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return ScaffoldBackGroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const BeaconAppBar(
          title: "Change Password",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet(context) ? 10.w : 24.w),
                      child: BeaconTextFormField(
                        labelText: "New Password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet(context) ? 12.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                        floatingStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet(context) ? 15.sp : 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                        controller: newPassword,
                        verticalPadding: 10.h,
                        horizontalPadding: 25.w,
                        radius: 25.r,
                        backgroundColor: const Color(0xFFFFFFFF),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFA9A9A9)),
                      )),
                  SizedBox(height: 13.h),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet(context) ? 10.w : 24.w),
                      child: BeaconTextFormField(
                        labelText: "Confirm Password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet(context) ? 12.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                        floatingStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet(context) ? 15.sp : 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                        controller: confirmPassword,
                        verticalPadding: 10.h,
                        horizontalPadding: 25.w,
                        radius: 25.r,
                        backgroundColor: const Color(0xFFFFFFFF),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFA9A9A9)),
                      )),
                  SizedBox(
                    height: 13.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: isTablet(context) ? 60.w : 90.w,
                        bottom: 24.h,
                        left: isTablet(context) ? 60.w : 90.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        child: isLoading
                            ? SizedBox(
                                width: 230.w,
                                height: 40.h,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xFF1870FF)),
                                ),
                              )
                            : SizedBox(
                                child: CustomElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    FocusScope.of(context).unfocus();
                                    if (newPassword.text.isEmpty ||
                                        confirmPassword.text.isEmpty) {
                                        DialogueUtils.popUpMessageDialogue(
                                        context: context,
                                        message: "Password fields must not be empty",
                                        popUpType: PopUpType.error,
                                      );   
                                
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else if (newPassword.text !=
                                        confirmPassword.text) {
                                      DialogueUtils.popUpMessageDialogue(
                                        context: context,
                                        message: "Password is not match",
                                        popUpType: PopUpType.error,
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      await authProvider.changePassword(
                                        confirmPassword.text,
                                        onErrorState: (val) {
                                           DialogueUtils.popUpMessageDialogue(
                                            context: context,
                                            message: val.response?.exception
                                                    ?.message ??
                                                "",
                                            popUpType: PopUpType.error,
                                          );
                                         
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        onLoadedState: (val) {
                                          isLoading = false;
                                          if (widget.userTypeId == 1) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DashBoardScreen()),
                                              (route) => false,
                                            );
                                          } else if (widget.userTypeId == 4) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ManagerDashBoardScreen()),
                                              (route) => false,
                                            );
                                          } else {}

                                          // popUpMessageDialogue(
                                          //   context: context,
                                          //   message:
                                          //       "Password changed successfully.",
                                          // );
                                        },
                                      );
                                    }
                                  },
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF1870FF), // Start color
                                      Color(0xFF2E5698), // End color
                                    ],
                                  ),
                                  text1: 'Change Password',
                                  ftSize: isTablet(context) ? 8.sp : 15.sp,
                                  bdRadius: 20.r,
                                ),
                              ),
                      ),
                    ),
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
