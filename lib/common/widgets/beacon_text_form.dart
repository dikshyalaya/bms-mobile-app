// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeaconTextFormField extends StatefulWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final bool isPassword;
  final int? maxLines;
  final TextStyle? hintStyle;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final BorderSide? borderSide;
  final GlobalKey<FormState>? formKey;
  final TextInputAction? inputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  final int? maxLength;
  final String? labelText;
  final bool? isError;
  final TextStyle? labelStyle;
  final TextStyle? floatingStyle;
  const BeaconTextFormField(
      {Key? key,
      this.controller,
      this.validator,
      this.hintText,
      this.onTap,
      this.readOnly = false,
      this.suffixIcon,
      this.maxLines,
      this.isPassword = false,
      this.textInputType,
      this.prefixIcon,
      this.backgroundColor,
      this.textColor,
      this.hintStyle,
      this.radius,
      this.verticalPadding,
      this.horizontalPadding,
      this.borderSide,
      this.formKey,
      this.inputAction,
      this.onChanged,
      this.onFieldSubmitted,
      this.maxLength,
      this.initialValue,
      this.labelText,
      this.isError,
      this.labelStyle,
      this.floatingStyle})
      : super(key: key);

  @override
  State<BeaconTextFormField> createState() => _BeaconTextFormFieldState();
}

class _BeaconTextFormFieldState extends State<BeaconTextFormField> {
  late bool isPassword;

  @override
  void initState() {
    isPassword = widget.isPassword;
    super.initState();
    isTablet();
  }
isTablet(){
  setState(() {
   isTabletDevice =  getBool("isTablet");
  });
  
}
bool? isTabletDevice;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      // enableSuggestions: false,
      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
      // autofocus: true,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      textInputAction: widget.inputAction,
      key: widget.formKey,
      style: TextStyle(color: widget.textColor,fontWeight:isTabletDevice == true?FontWeight.normal: FontWeight.bold ,fontSize: isTabletDevice == true?12.sp:15.sp),
      onTap: widget.onTap,
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      obscureText: isPassword,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        // focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide:
              widget.borderSide ?? const BorderSide(color: Color(0xFFFFFFFF)),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 7.r)),
        ),
        // counterStyle: TextStyle(height: double.minPositive,),
        //  counterText: "",
        counterStyle:
            TextStyle(color: Theme.of(context).colorScheme.background),
        labelStyle: widget.labelStyle,
        // Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15.sp),
        floatingLabelStyle: widget.floatingStyle,
        // Theme.of(context)
        //     .textTheme
        //     .bodyText2!
        //     .copyWith(fontSize: 18.sp, color: Colors.teal),
        labelText: widget.labelText,
        fillColor:
            widget.backgroundColor ?? Theme.of(context).colorScheme.background,
        filled: true,
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding ?? 12.w,
          vertical: widget.verticalPadding ?? 16.h,
        ),
        border: OutlineInputBorder(
          borderSide:
              widget.borderSide ?? const BorderSide(color: Color(0xFF3C85FF)),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 7.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              widget.borderSide ?? const BorderSide(color: Color(0xFF3C85FF)),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 7.r)),
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: Colors.black54,
                ),
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    child: isPassword
                        ? Padding(
                          padding:  EdgeInsets.only(right:8.w),
                          child: Icon(Icons.visibility,
                              size: 20.sp,
                              color:
                                  Theme.of(context).brightness == Brightness.light
                                      ? Colors.grey
                                      : Colors.grey),
                        )
                        : Padding(
                          padding:  EdgeInsets.only(right:8.w),
                          child: Icon(Icons.visibility_off,
                              size: 20.sp,
                              color:
                                  Theme.of(context).brightness == Brightness.light
                                      ? Colors.grey
                                      : Colors.grey),
                        )
                    // SvgPicture.asset(
                    //     isPassword ? AppIcons.eyeShow : AppIcons.eyeHide,
                    //     height: 20.h,
                    //     width: 20.w,
                    //     color: Theme.of(context).brightness == Brightness.light
                    //         ? Colors.grey
                    //         : Colors.grey),
                    )
                : null),
      ),
    );
  }
}
