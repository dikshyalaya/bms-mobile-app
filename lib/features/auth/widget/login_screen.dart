// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/constants/app_images.dart';
import 'package:beacon_flutter/empty_dash_board.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/service/generate_fcm_token.dart';
import 'package:beacon_flutter/utils/constants.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
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
          child: Container(
            // color: Colors.red,
            height: 420.h,
            width: 381.w,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90.h, left: 15.w, right: 12.w),
                  child: Column(
                    children: [
                      Container(
                        height: 280.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                    0x25000000), // 25% opacity black
                                offset: const Offset(0, 4), // X=0, Y=4
                                blurRadius: 4.r,
                                spreadRadius: 0,
                              ),
                            ],
                            color: const Color(0xFF3C85FF),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 14.h),
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                              BeaconTextFormField(
                                controller: _username,
                                verticalPadding: 0,
                                horizontalPadding: 0,
                                prefixIcon: Icon(
                                  Icons.account_circle_rounded,
                                  color: Color(0xFFC1C1C1),
                                ),
                                radius: 25.r,
                                backgroundColor: Color(0xFFFFFFFF),
                                hintText: 'Username',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Color(0xFFC1C1C1)),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              BeaconTextFormField(
                                controller: _password,
                                isPassword: true,
                                verticalPadding: 0,
                                horizontalPadding: 0,
                                prefixIcon:
                                    Icon(Icons.lock, color: Color(0xFFC1C1C1)),
                                radius: 25.r,
                                backgroundColor: Colors.white,
                                hintText: 'Password',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Color(0xFFC1C1C1)),
                              ),

                              Align(alignment: Alignment.centerRight,child: SizedBox(width: 104,child: CustomElevatedButton(text1: 'Login',bdRadius: 20.r,)))

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      const Text('The Beacon Group')
                    ],
                  ),
                ),
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
    // Scaffold(
    //   body: Container(
    // decoration: const BoxDecoration(
    //   color: Colors.grey,
    //   gradient: LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: [
    //       Color(0xFF003792), // Top part color
    //       Color(0xFF3E65A5), // Bottom part color
    //     ],
    //   ),
    // ),
    //     child:
    //     Center(
    //       child: Container(
    //         alignment: Alignment.center,
    // height: MediaQuery.of(context).size.height,
    // width: 500,
    //         child: SizedBox(
    //           height: DimensionUtils.isTab(context) ? 432 : 456,
    //           width: double.infinity,
    //           child: Stack(
    //             alignment: Alignment.bottomCenter,
    //             children: [
    //               SizedBox(
    //                 height: 389,
    //                 width: double.infinity,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Card(
    //                       color: Theme.of(context).cardColor,
    //                       elevation: 4,
    //                       margin: const EdgeInsetsDirectional.all(
    //                           horizontalPadding),
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(15)),
    //                       child: SizedBox(
    //                         width: double.infinity,
    //                         child: Padding(
    //                           padding: const EdgeInsetsDirectional.only(
    //                               top: 32, start: 22, end: 22, bottom: 18),
    //                           child: Padding(
    //                             padding: EdgeInsetsDirectional.symmetric(
    //                                 horizontal:
    //                                     DimensionUtils.isTab(context) ? 40 : 0),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    // Text(
    //   "LOGIN",
    //   style: Theme.of(context)
    //       .textTheme
    //       .bodyLarge!
    //       .copyWith(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 20),
    // ),
    //                                 const SizedBox(
    //                                   height: 19,
    //                                 ),
    //                                 BeaconTextFormField(
    //                                   iconData: Icons.person_pin,
    //                                   hintText: "Username",
    //                                   onChangedInput: (String input) {
    //                                     userName = input;
    //                                   },
    //                                 ),
    //                                 const SizedBox(
    //                                   height: 12,
    //                                 ),
    //                                 BeaconTextFormField(
    //                                   obscureText: true,
    //                                   iconData: Icons.lock,
    //                                   hintText: "Password",
    //                                   onChangedInput: (String input) {
    //                                     password = input;
    //                                   },
    //                                 ),
    //                                 const SizedBox(
    //                                   height: 12,
    //                                 ),
    //                                 Align(
    //                                   alignment: Alignment.centerRight,
    //                                   child: SizedBox(
    //                                     height: 40,
    //                                     width: 104.84,
    //                                     child: ElevatedButton(
    //                                         onPressed: () async {
    //                                           if (userName.isEmpty ||
    //                                               password.isEmpty) {
    //                                             final errorMessage = userName
    //                                                     .isEmpty
    //                                                 ? "Username is Required."
    //                                                 : "Password is Required.";
    //                                             DialogueUtils.showErrorDialogue(
    //                                                 context: context,
    //                                                 message: errorMessage);
    //                                           } else {
    //                                             FocusScope.of(context)
    //                                                 .unfocus();
    //                                             DialogueUtils.showProgressDialogue(
    //                                                 context,
    //                                                 "Signing in, Please wait...");
    //                                                 generateFCMToken();

    //                                             await authProvider.logIn(
    //                                                 userName, password,
    //                                                 onErrorState: (val) {
    //                                               Navigator.pop(context);
    //                                               shoErrorToast(val
    //                                                       .response
    //                                                       ?.exception
    //                                                       ?.message ??
    //                                                   "");
    //                                             }, onAccessToken:
    //                                                     (Map<String, dynamic>
    //                                                         onData) {
    //                                               Navigator.pop(context);

    //                                               if (onData['data'] != null) {
    //                                                 final accessToken =
    //                                                     onData["accessToken"];
    //                                                 final email =
    //                                                     onData['data']['email'];
    //                                                 final isActive =
    //                                                     onData['data']
    //                                                         ['isActive'];
    //                                                 final userTypeId =
    //                                                     onData['data']
    //                                                         ['userTypeId'];
    //                                                 final empId =
    //                                                     onData['data']['empId'];
    //                                                 final empFirstName =
    //                                                     onData['data']
    //                                                             ['employee']
    //                                                         ['empFirstName'];
    //                                                 final empLastName =
    //                                                     onData['data']
    //                                                             ['employee']
    //                                                         ['empLastName'];
    //                                                 authProvider.savedLoginInfo(
    //                                                     accessToken,
    //                                                     BmsUserModel(
    //                                                         email: email,
    //                                                         isActive: isActive,
    //                                                         userTypeId:
    //                                                             userTypeId,
    //                                                         empFirstName:
    //                                                             empFirstName,
    //                                                         empLastName:
    //                                                             empLastName,
    //                                                         empId: empId));

    //                                                 if (userTypeId == 1) {
    //                                                   Navigator.pushAndRemoveUntil(
    //                                                       context,
    //                                                       MaterialPageRoute(
    //                                                           builder: (context) =>
    //                                                               const DashBoardScreen()),
    //                                                       (route) => false);
    //                                                 } else if (userTypeId ==
    //                                                     4) {
    //                                                   Navigator.pushAndRemoveUntil(
    //                                                       context,
    //                                                       MaterialPageRoute(
    //                                                           builder: (context) =>
    //                                                               const ManagerDashBoardScreen()),
    //                                                       (route) => false);
    //                                                 } else {
    //                                                   Navigator.pushAndRemoveUntil(
    //                                                       context,
    //                                                       MaterialPageRoute(
    //                                                           builder: (context) =>
    //                                                               const EmptyDashBoard()),
    //                                                       (route) => false);
    //                                                 }
    //                                               } else {
    //                                                 shoErrorToast(
    //                                                     onData['message']);
    //                                               }
    //                                             });
    //                                           }
    //                                         },
    //                                         style: ButtonStyle(
    //                                             padding: MaterialStateProperty.all(
    //                                                 const EdgeInsetsDirectional
    //                                                     .only(
    //                                               start: 12,
    //                                               end: 12,
    //                                             )),
    //                                             elevation: MaterialStateProperty.all(
    //                                                 4),
    //                                             backgroundColor:
    //                                                 MaterialStateProperty.all(
    //                                                     const Color(
    //                                                         0xff1870FF)),
    //                                             shape: MaterialStateProperty.all(
    //                                                 const RoundedRectangleBorder(
    //                                                     borderRadius:
    //                                                         BorderRadius.all(
    //                                                             Radius.circular(
    //                                                                 20))))),
    //                                         child: Text(
    //                                           "Login",
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .bodyLarge!
    //                                               .copyWith(
    //                                                   fontSize: 13,
    //                                                   color: Colors.white,
    //                                                   fontWeight:
    //                                                       FontWeight.bold),
    //                                         )),
    //                                   ),
    //                                 ),
    //                                 const SizedBox(
    //                                   height: 12,
    //                                 ),
    //                                 Text(
    //                                   "Forgot your password ?",
    //                                   style: Theme.of(context)
    //                                       .textTheme
    //                                       .bodyLarge!
    //                                       .copyWith(
    //                                           color: Colors.white,
    //                                           fontWeight: FontWeight.w400,
    //                                           fontSize: 15),
    //                                 ),
    //                                 const SizedBox(
    //                                   height: 15,
    //                                 ),
    //                                 Text.rich(
    //                                   TextSpan(
    //                                     children: [
    //                                       TextSpan(
    //                                         text: 'No worries, click, ',
    //                                         style: Theme.of(context)
    //                                             .textTheme
    //                                             .bodyLarge!
    //                                             .copyWith(
    //                                               color: Colors.white,
    //                                               fontWeight: FontWeight.w400,
    //                                               fontSize: 15,
    //                                             ),
    //                                       ),
    //                                       TextSpan(
    //                                         text: 'HERE',
    //                                         recognizer: TapGestureRecognizer()
    //                                           ..onTap = () => DialogueUtils
    //                                               .resetLinkDialogue(
    //                                                   context: context),
    //                                         style: Theme.of(context)
    //                                             .textTheme
    //                                             .bodyLarge!
    //                                             .copyWith(
    //                                               color: Colors.white,
    //                                               fontWeight: FontWeight.w500,
    //                                               fontSize: 15,
    //                                             ),
    //                                       ),
    //                                       TextSpan(
    //                                         text: ' to reset your password.',
    //                                         style: Theme.of(context)
    //                                             .textTheme
    //                                             .bodyLarge!
    //                                             .copyWith(
    //                                               color: Colors.white,
    //                                               fontWeight: FontWeight.w400,
    //                                               fontSize: 15,
    //                                             ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   textAlign: TextAlign.center,
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     Text(
    //                       'The Beacon Group',
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .bodyLarge!
    //                           .copyWith(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: 13),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 0,
    // child: Image.asset(
    //   "app-logo".pngImage(),
    //   height: 107,
    //   width: 107,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

void shoErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message, backgroundColor: Colors.red, textColor: Colors.white);
}
