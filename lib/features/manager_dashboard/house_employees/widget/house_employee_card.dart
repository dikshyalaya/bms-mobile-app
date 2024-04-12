import 'package:beacon_flutter/features/manager_dashboard/house_employees/widget/house_employee_header_card.dart';
import 'package:flutter/material.dart';

class HouseEmployeeCard extends StatefulWidget {
  const HouseEmployeeCard({Key? key}) : super(key: key);

  @override
  State<HouseEmployeeCard> createState() => _HouseEmployeetCardState();
}

class _HouseEmployeetCardState extends State<HouseEmployeeCard> {
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HouseEmployeeHeaderCard(),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Email:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Status:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(456) 789-4564",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "sandip@gharero.com",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    SizedBox(
                      height: 19,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.zero),
                            elevation: MaterialStateProperty.all(4),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff00851D)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        child: Text(
                          "Active",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 22,
            padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
