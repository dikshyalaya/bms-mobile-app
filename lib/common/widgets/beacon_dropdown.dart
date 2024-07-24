import 'package:flutter/material.dart';

class BeaconDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemAsString;
  final ValueChanged<T?> onChanged;
  final String? hint;

  const BeaconDropdown({
    Key? key,
    required this.items,
    this.selectedItem,
    required this.itemAsString,
    required this.onChanged,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: hint != null ? Text(hint!) : const Text("Select"),
          value: selectedItem,
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(itemAsString(value)),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
        ),
      ),
    );
  }
}
