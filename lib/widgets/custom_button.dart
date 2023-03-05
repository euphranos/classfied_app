// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.green),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
