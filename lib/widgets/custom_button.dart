import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.icon});

  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFF26A59A),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 150,
        height: 150,
        child: Icon(icon, size: 80, color: Colors.white),
      ),
    );
  }
}
