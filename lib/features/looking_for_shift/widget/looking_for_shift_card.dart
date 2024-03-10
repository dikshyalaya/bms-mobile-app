import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_card_header.dart';
import 'package:flutter/material.dart';
class LookingForShiftCard extends StatefulWidget {
  final int index;
  const LookingForShiftCard({Key? key,required this.index}) : super(key: key);

  @override
  State<LookingForShiftCard> createState() => _LookingForShiftCardState();
}

class _LookingForShiftCardState extends State<LookingForShiftCard> {
  bool isTrue =false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 138,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [const LookingForShiftCardHeader(),  const SizedBox(height: 11,),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 19),
              child: Text("Adapt - Brooklyn IRA (Apt 6N)",style: TextStyle(
                color: Color(0xff1B1B1B),
                fontWeight: FontWeight.w500,
                fontSize: 13
              ),),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 19),

              child: Text("175 Willoughby St,Brooklyn,NY 11201",style: TextStyle(
                color: Color(0xff1B1B1B),
                fontWeight: FontWeight.w400,
                fontSize: 13
              ),),
            ),
             const Divider(color: Color(0xffEDEDED),),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
const Text("Available?",style: TextStyle(
  fontSize: 15,fontWeight: FontWeight.w500,
),),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,height: 22,
                        child: FittedBox(
                          child: Switch(
                            key: UniqueKey(),

                              value: isTrue, onChanged: (bool val){
                              setState(() {
                                isTrue =val;
                              });
                          }),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      const Text("Yes",style: TextStyle(
                        color: Color(0xff324054),
                        fontSize: 12
                      ),)
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
