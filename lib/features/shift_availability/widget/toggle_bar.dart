import 'package:flutter/material.dart';

class ToggleBar extends StatelessWidget {
  const ToggleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 20,
        width: 200,
        child: Row(
          children: [
              Expanded(
              child:  cardBuilder(shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
              ),text: "Date"),
            ),
           const SizedBox(width: 1,),
            Expanded(
              child:  cardBuilder(shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
              ),text: "Distance"),
            ),
          ],
        ));
  }

  SizedBox cardBuilder({ShapeBorder?shape, required String text}) {
    return  SizedBox(
              height: 20,
              child: Card(
                elevation: 6,
                margin: EdgeInsets.zero,
                color:  const Color(0xff4579FF),
                shape:shape ,
                child:  Center(child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 12),)),
              ),
            );
  }
}
