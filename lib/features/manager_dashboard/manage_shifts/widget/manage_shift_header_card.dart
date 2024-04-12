import 'package:flutter/material.dart';

class ManageShiftHeaderCard extends StatelessWidget {
  const ManageShiftHeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
      decoration: const BoxDecoration(
        color: Color(0xffD7ECFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          const Text(
            "Requested:",
            style: TextStyle(
              color: Color(0xff8A8181),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "ANY",
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          InkWell(
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.38),
                    offset: const Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
              ),
              // child: Image.asset('edit'.iconImage()),
              child: const Icon(
                Icons.edit_note_outlined,
                color: Color(0xFF325CA1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
