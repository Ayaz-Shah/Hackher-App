import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomNeedButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  CustomNeedButton({required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFE7407D) : Color(0xffF3F2F7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.rubik(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

