import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:flutter/material.dart';

class BMSDropDownForm extends StatelessWidget {
  final List<String> options;
  final Function(String) onChooseOptions;
  final double? width;
  final String? hint;
  final bool? ignoring;
  const BMSDropDownForm(
      {Key? key,
      required this.options,
      required this.onChooseOptions,
      this.width,
      this.hint,
      this.ignoring})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width ?? 184,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xffA9A9A9))),
      padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
      child: IfElseBuilder(
        condition: ignoring ?? false,
        elseBulider: (context) {
          return DropdownButtonHideUnderline(
            child: IgnorePointer(
              ignoring: ignoring ?? false,
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                hint: IfBuilder(
                    condition: options.first.isNotEmpty || hint != null,
                    builder: (context) {
                      return FittedBox(
                          child: Text(
                        hint ?? options.first,
                        maxLines: 1,
                      ));
                    }),
                isExpanded: true,
                items: options
                    .where((element) => element.isNotEmpty)
                    .toList()
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  onChooseOptions.call(val ?? "");
                },
              ),
            ),
          );
        },
        ifBuilder: (context) => const FittedBox(child: Text('')),
      ),
    );
  }
}
