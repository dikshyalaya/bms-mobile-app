import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyDashBoard extends StatelessWidget {
  const EmptyDashBoard({key});

  @override
  Widget build(BuildContext context) {
    return  ScaffoldBackGroundWrapper(child: Scaffold(
      appBar: BeaconAppBar(
        title: Provider.of<AuthProvider>(context,listen: false).userFullName,

      ),
      backgroundColor: Colors.transparent,body: const Padding(padding: EdgeInsets.symmetric(horizontal: 31,vertical: 42),child: Text("Please contact System Administrator for setting up the App Permission.",
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),),));
  }
}
