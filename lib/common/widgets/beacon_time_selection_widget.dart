// import 'package:flutter/material.dart';

// class BeaconTimeSelectionWidget extends StatefulWidget {
//   final String title;
//   final Function(TimeOfDay) onTimeSelected;
//   final TextEditingController? controller;

//   const BeaconTimeSelectionWidget({
//     Key? key,
//     required this.title,
//     required this.onTimeSelected,
//     this.controller,
//   }) : super(key: key);

//   @override
//   State<BeaconTimeSelectionWidget> createState() =>
//       _BeaconTimeSelectionWidgetState();
// }

// class _BeaconTimeSelectionWidgetState extends State<BeaconTimeSelectionWidget> {
//   late TimeOfDay _selectedTime;

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//       widget.onTimeSelected(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       style: const TextStyle(
//         fontWeight: FontWeight.normal,
//       ),
//       readOnly: true,
//       onTap: () => _selectTime(context),
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//         hintText: widget.title,
//         suffixIcon: const Icon(Icons.access_time),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       controller: widget.controller,
//     );
//   }
// }

import 'package:flutter/material.dart';

class BeaconTimeSelectionWidget extends StatefulWidget {
  final String title;
  final Function(TimeOfDay) onTimeSelected;
  final TextEditingController? controller;

  const BeaconTimeSelectionWidget({
    Key? key,
    required this.title,
    required this.onTimeSelected,
    this.controller,
  }) : super(key: key);

  @override
  State<BeaconTimeSelectionWidget> createState() =>
      _BeaconTimeSelectionWidgetState();
}

class _BeaconTimeSelectionWidgetState extends State<BeaconTimeSelectionWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now(); // Initialize _selectedTime with the current time
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      readOnly: true,
      onTap: () => _selectTime(context),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: widget.title,
        suffixIcon: const Icon(Icons.access_time),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: widget.controller,
    );
  }
}
