import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/domain/MyScheduleProvider.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/domain/auth_provider.dart';

class MyScheduleHomeScreen extends StatefulWidget {
  const MyScheduleHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyScheduleHomeScreen> createState() => _MyScheduleHomeScreenState();
}

class _MyScheduleHomeScreenState extends State<MyScheduleHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthProvider, MyScheduleProvider>(
      update: (_, authProvider, clockInProvide) {
        return MyScheduleProvider(authProvider.bmsUserModel?.empId ?? 0)
          ..getAvailableShiftsForDcModel()
          ..getListHouseForDCAddShift();
      },
      lazy: false,
      create: (_) => MyScheduleProvider(0),
      builder: (context, child) => ScaffoldBackGroundWrapper(
          appBar: BeaconAppBar(
            title: "My Schedule",
            action: [
              GestureDetector(
                onTap: () async {
                  DialogueUtils.onPressedMyScheduleDialogue(
                      context: context,
                      onSaveSchedule: () {
                        Navigator.pop(context);
                        DialogueUtils.successMessageDialogue(
                            context: context,
                            successMessage: "Shift Added Successfully.");
                      },
                      listHouseForDcAddShiftModel:
                          Provider.of<MyScheduleProvider>(context,
                                  listen: false)
                              .listHouseForDCAddShiftModel);
                },
                child: SizedBox(
                  height: 34,
                  width: 34,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34)),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xff325CA1),
                    ),
                  ),
                ),
              )
            ],
            leadingIcon: const AppBarLeadingIcon(),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Selector<MyScheduleProvider, bool>(
                  builder: (context, isDataFetching, child) {
                    final availableShiftsForDcModel =
                        Provider.of<MyScheduleProvider>(context, listen: false)
                            .availableShiftsForDcModel;

                    return ServerResponseBuilder(
                        builder: (context) => availableShiftsForDcModel.data!.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 22),
                          child: Align(alignment: Alignment.topCenter,child: Text('No Record Found',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)),
                        ) : ListView.builder(
                             itemBuilder: (context, index) => Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                               child: MySchedulecard(
                                 scheduleCardModel:
                                     availableShiftsForDcModel.data![index],
                                 index: index,
                                 onFinished: (){
                                   setState(() {
                               
                                   });
                                 },
                               ),
                             ),
                             itemCount:
                                 availableShiftsForDcModel.data!.length,
                           ),
                        isDataFetching: isDataFetching,
                        isNullData: availableShiftsForDcModel.data == null);
                  },
                  selector: (context, provider) => provider.isDataFetching))),
    );
  }
}
