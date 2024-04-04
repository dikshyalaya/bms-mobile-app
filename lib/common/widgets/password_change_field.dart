import 'package:flutter/material.dart';

class PWChangeTextFormField extends StatefulWidget {
  final Function(String) onChangedInput;
  final bool? obscureText;
  final double? height;
  final double? textStyleSize;
  const PWChangeTextFormField(
      {Key? key,
      this.textStyleSize,
      this.obscureText = false,
      this.height,
      required this.onChangedInput})
      : super(key: key);

  @override
  State<PWChangeTextFormField> createState() => _PWChangeTextFormFieldState();
}

class _PWChangeTextFormFieldState extends State<PWChangeTextFormField> {
  @override
  Widget build(BuildContext context) {
    // const iconColor = Color(0xffA5A5A5);
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          disabledBorder: outlineImputBorder(),
          enabledBorder: outlineImputBorder(),
          focusedBorder: outlineImputBorder(),
          border: outlineImputBorder(),
          fillColor: Colors.white,
          labelStyle:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
          filled: true,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: widget.textStyleSize ?? 13,
              color: textColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  OutlineInputBorder outlineImputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(
        color: Color(0xffA9A9A9),
      ),
    );
  }
}
