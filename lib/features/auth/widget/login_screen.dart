import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/empty_dash_board.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/utils/constants.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height:  MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.shortestSide > 600?600: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "login_bg".pngImage(),
            ),
            fit: BoxFit.fill,
          )),
          child: SizedBox(
            height: 442,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      color: Theme.of(context).cardColor,
                      elevation: 4,
                      margin: const EdgeInsetsDirectional.all(horizontalPadding),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 32, start: 22, end: 22, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              const SizedBox(
                                height: 19,
                              ),
                              BeaconTextFormField(
                                iconData: Icons.person_pin,
                                hintText: "Username",
                                onChangedInput: (String input) {
                                  userName = input;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              BeaconTextFormField(
                                obscureText: true,
                                iconData: Icons.lock,
                                hintText: "Password",
                                onChangedInput: (String input) {
                                  password = input;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 40,
                                  width: 104.84,
                                  child: ElevatedButton(
                                      onPressed: () async{
                                        if (userName.isEmpty ||
                                            password.isEmpty) {
                                          final errorMessage = userName.isEmpty
                                              ? "Username is Required."
                                              : "Password is Required.";
                                          DialogueUtils.showErrorDialogue(
                                              context: context,
                                              message: errorMessage);
                                        } else {
                                          FocusScope.of(context).unfocus();
                                          DialogueUtils.showProgressDialogue(context,  "Signing in, Please wait...");
        
                                         await authProvider.logIn(userName, password,onErrorState: (val){
                                           Navigator.pop(context);
                shoErrorToast(val.response?.exception?.message??"") ;                                      },
                                          onAccessToken: (Map<String,dynamic>onData){
                                           Navigator.pop(context);
        
                                            if(onData['data']!=null){
                                              final accessToken = onData["accessToken"];
                                              final email = onData['data']['email'];
                                              final isActive = onData['data']['isActive'];
                                              final userTypeId = onData['data']['userTypeId'];
                                              final empId = onData['data']['empId'];
                                              final empFirstName = onData['data']['employee']['empFirstName'];
                                              final empLastName = onData['data']['employee']['empLastName'];
                                              authProvider.savedLoginInfo(accessToken, BmsUserModel(email: email,isActive: isActive,userTypeId: userTypeId,empFirstName: empFirstName,empLastName: empLastName,empId: empId));
        
                                              if(userTypeId==1){
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const DashBoardScreen()),
                                                        (route) => false);
                                              }
        
                                              else if(userTypeId==4){
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const ManagerDashBoardScreen()),
                                                        (route) => false);
                                              }
        
                                              else{
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const EmptyDashBoard()),
                                                        (route) => false);
                                              }
                                            }
                                            else{
                                            shoErrorToast(onData['message']);
        
                                            }
        
        
                                          }
                                          );
        
                                        }
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsetsDirectional.only(
                                            start: 12,
                                            end: 12,
                                          )),
                                          elevation: MaterialStateProperty.all(4),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff1870FF)),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))))),
                                      child: Text(
                                        "Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Forgot your password ?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text.rich(
        
        
                                TextSpan(
        
                                  children: [
                                    TextSpan(
                                      text: 'No worries, click, ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                    ),
                                    TextSpan(
                                      text: 'HERE',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            DialogueUtils.resetLinkDialogue(
                                                context: context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' to reset your password.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'The Beacon Group',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    )
                  ],
                ),
                Image.asset(
                  "app-logo".pngImage(),
                  height: 107,
                  width: 107,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void shoErrorToast(String message){
  Fluttertoast.showToast(msg: message,backgroundColor: Colors.red,textColor: Colors.white);
}