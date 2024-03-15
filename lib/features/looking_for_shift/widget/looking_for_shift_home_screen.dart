import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_provider.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/scaffold_background_wrapper.dart';
import '../data/schedule_period_response_model.dart';

class LookingForShiftHomeScreen extends StatefulWidget {
  const LookingForShiftHomeScreen({Key? key}) : super(key: key);

  @override
  State<LookingForShiftHomeScreen> createState() => _LookingForShiftHomeScreenState();
}

class _LookingForShiftHomeScreenState extends State<LookingForShiftHomeScreen> {
  bool isInit =true;
  late LookingForShiftProvider _lookingForShiftProvider;
  String schedulePeriod = "";
  bool initialState = true;

  @override
  void initState() {
    // TODO: implement initState
    _lookingForShiftProvider = Provider.of<LookingForShiftProvider>(context,listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() async{

    // TODO: implement didChangeDependencies
    if(isInit){
      await onInitScreen();
    }
    isInit =false;
    super.didChangeDependencies();
  }
  Future<void> onInitScreen() async {
     if(_lookingForShiftProvider.schedulePeriodResponseModel?.data?.isNotEmpty??false){
    Future.delayed(const Duration(milliseconds: 200),()async{
      final res = await DialogueUtils.selectSchedulePeriodDialogue(context: context, schedulePeriods: _lookingForShiftProvider.schedulePeriodResponseModel!.data!)??"";

     setState(() {
       initialState = false;
       schedulePeriod =res;
     });
      await _lookingForShiftProvider.getAllLookingForShift(schedulePeriod);
    });
    }
    else{
     await _lookingForShiftProvider.getAllSchedulePeriods().then((value)async {
       if(value.body?.data?.isNotEmpty??false){
         setState(() {
           initialState = false;
           // schedulePeriod = value.body?.data?.first.schedulePeriod??"";
         });
         final res = await  DialogueUtils.selectSchedulePeriodDialogue(context: context, schedulePeriods: value.body?.data??[])??"";

         setState(() {
           schedulePeriod =res;
         });
         await _lookingForShiftProvider.getAllLookingForShift(schedulePeriod);
       }


      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      child: Scaffold(
        appBar: BeaconAppBar(
          leadingIcon: const AppBarLeadingIcon(),
          action: [
            GestureDetector(
              onTap: () async {
               if( _lookingForShiftProvider.schedulePeriodResponseModel?.data?.isNotEmpty??false){
                 await onOpenPeriodDialogue(context);
               }

              },
              child: SizedBox(
                height: 34,
                width: 34,
                child: Card(
                  margin:  EdgeInsets.zero,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34)
                  ),
                  child: const Icon(Icons.calendar_month,color: Color(0xff04437F),),
                ),
              ),
            )
          ],
          title: "Looking For Shift",

        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: IfBuilder(
            condition: !initialState,
            builder: (context) {
              return Column(

                children: [
                   Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                              text: "Schedule Period: ",
                              style: TextStyle(color: Colors.white, fontSize: 15)),
                          TextSpan(
                            text: schedulePeriod,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),

                  Expanded(
                    child: Selector<LookingForShiftProvider,bool>(builder: (context,isDataFetching,child)=>ServerResponseBuilder(builder: (context)=>ListView.separated(
                      // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>  LookingForShiftCard(index: index,lookForShiftModel:_lookingForShiftProvider.lookForShiftResponseModel?.data?[index] ,),
                        padding: const EdgeInsets.only(bottom: 18),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 9,
                        ),
                        itemCount: _lookingForShiftProvider.lookForShiftResponseModel?.data?.length??0), isDataFetching: isDataFetching, isNullData: _lookingForShiftProvider.lookForShiftResponseModel?.data==null), selector: (context,provider)=>provider.isDataFetching),
                  )
              ,
                   SizedBox(
                    height: 74,
                    child: Center(
                      child: Padding(padding: const EdgeInsetsDirectional.only(top: 10),child: SizedBox(
                        height: 40,
                        width: 163,
                        child: ElevatedButton(
                            onPressed: () {
                             DialogueUtils.successMessageDialogue(context: context, successMessage: "Availability Saved Successfully.");
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsetsDirectional.zero),
                                elevation: MaterialStateProperty.all(4),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff1870FF)),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))))),
                            child: Text(
                              "Save",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Future<void> onOpenPeriodDialogue(BuildContext context) async {
     final res= await   DialogueUtils.selectSchedulePeriodDialogue(context: context, schedulePeriods: _lookingForShiftProvider.schedulePeriodResponseModel!.data!);

    setState(() {
      schedulePeriod =res??"";
    });

    _lookingForShiftProvider.getAllLookingForShift(schedulePeriod);
  }
}
