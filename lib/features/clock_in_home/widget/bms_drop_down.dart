import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMSDropDownForm extends StatelessWidget {
  List<String> options;
  Function(String)onChooseOptions;
  double? width;
  final String? hint;
  final bool? ignoring;
   BMSDropDownForm({super.key,required this.options,required this.onChooseOptions,this.width,this.hint,this.ignoring});

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
        child: IgnorePointer(
          ignoring: ignoring??false,
          child: DropdownButton<String>(

            underline: const SizedBox.shrink(),
            focusColor:  Colors.white,
            hint: Text(hint??options.first),
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
      ),
    );
  }
}
