import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 68),
          child: Selector<AuthProvider, BmsUserModel?>(
            selector: (context, provider) => provider.bmsUserModel,
            builder: (context, bmsUserModel, child) => BeaconAppBar(
              title:
                  "${bmsUserModel?.empFirstName} ${bmsUserModel?.empLastName}",
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF174CD6), // Top part color
              Color(0xFF98BBFF), // Bottom part color
            ],
          ),
        ),
        child: const Column(),
      ),
    );
  }
}
