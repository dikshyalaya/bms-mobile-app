import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMSDropDownForm extends StatelessWidget {
  List<String> options;
  Function(String)onChooseOptions;
  double? width;
   BMSDropDownForm({super.key,required this.options,required this.onChooseOptions,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width:width?? 184,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color(0xffA9A9A9)
          )
      ),
      padding: const EdgeInsetsDirectional.only(start: 8,end: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          focusColor:  Colors.white,
          hint: Text(options.first),
          isExpanded: true,
        
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {
            onChooseOptions.call(val??"");
          },
        ),
      ),
    );
  }
}
