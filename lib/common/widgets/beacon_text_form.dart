import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:flutter/material.dart';

class BeaconTextFormField extends StatefulWidget {
  final IconData iconData;
  final String hintText;
  final Function(String) onChangedInput;
  bool? obscureText;
  final double? height;
  BeaconTextFormField(
      {Key? key,
      required this.iconData,
      required this.hintText,
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
    return SizedBox(
      height: widget.height ?? 34,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: TextFormField(
          obscureText: widget.obscureText ?? false,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12, letterSpacing: 1.2),
          onChanged: (String val) {
            widget.onChangedInput.call(val);
          },
          decoration: InputDecoration(
            // contentPadding:
            // const EdgeInsets.only(left: 10.0, right: 10, top: 15),
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            fillColor: Colors.white,
            labelStyle:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
            filled: true,
            hintText: widget.hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 12, color: iconColor),
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
                      ? Icons.remove_red_eye
                      : Icons.disabled_by_default_rounded,
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
      ),
    );
  }
}
