import 'package:beacon_flutter/features/notifications/data/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final Datum notification;
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Text(
            "${DateFormat('dd/MM/yyyy').format(notification.createdDate ?? DateTime.now())} - ${DateFormat('hh:mm a').format(notification.createdDate ?? DateTime.now())}",
            style: const TextStyle(
              color: Color(0xFF00872E),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
          child: Text(
            "${notification.title}",
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1,
                ),
                top: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1,
                ),
              )),
          child: Text(
            "${notification.body}",
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                customButton(
                  name: "Accept",
                  color: const Color(0xFF00872E),
                  onPressed: () {},
                ),
                const SizedBox(width: 6),
                customButton(
                  name: "Reject",
                  color: const Color(0xFFD90C0C),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Divider(),
        ),
      ],
    );
  }

  customButton({String? name, Color? color, Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 25,
        width: 65,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name ?? "",
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
