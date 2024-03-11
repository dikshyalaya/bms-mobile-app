import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:flutter/material.dart';

class BeaconTextFormField extends StatefulWidget {
  final IconData iconData;
  final String hintText;
  final Function(String) onChangedInput;
  bool? obscureText;
  final double? height;
  final double? textStyleSize;
  BeaconTextFormField(
      {Key? key,
      required this.iconData,
      required this.hintText,
        this.textStyleSize,
      this.obscureText = false,
      this.height,
      required this.onChangedInput})
      : super(key: key);

  @override
  State<BeaconTextFormField> createState() => _BeaconTextFormFieldState();
}

class _BeaconTextFormFieldState extends State<BeaconTextFormField> {
  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xffA5A5A5);
    const textColor = Color(0xffC1C1C1);
    return SizedBox(
      height: widget.height ?? 40,
      child: TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,

        obscureText: widget.obscureText ?? false,

        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 13, letterSpacing: 1.2),
        onChanged: (String val) {
          widget.onChangedInput.call(val);
        },
        decoration: InputDecoration(
          contentPadding:
           EdgeInsets.zero,
          disabledBorder: outlineImputBorder(),
          enabledBorder: outlineImputBorder(),
          focusedBorder:outlineImputBorder(),
          border:  outlineImputBorder(),
          fillColor: Colors.white,
          labelStyle:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
          filled: true,
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize:widget.textStyleSize??13, color: textColor,fontWeight: FontWeight.w500),
          prefixIcon: Icon(
            widget.iconData,
            size: 20,
            color: iconColor,
          ),
          suffixIcon: IfBuilder(
            condition: widget.hintText.toLowerCase() == "password",
            builder: (context) => IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  widget.obscureText!
                      ? widget.obscureText = false
                      : widget.obscureText = true;
                });
              },
              icon: Icon(
                (widget.obscureText ?? false)
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: iconColor,
                size: 20,
              ),
            ),
          ),

          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5.0),
          // ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineImputBorder() {
    return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  borderSide: const BorderSide(
  color: Colors.transparent,

  ),);
  }
}
