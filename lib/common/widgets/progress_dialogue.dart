import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String? message;
  const ProgressDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.shortestSide > 600
            ? 600
            : double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 26.0,
              ),
              Text(
                message ?? 'message',
                style: const TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
