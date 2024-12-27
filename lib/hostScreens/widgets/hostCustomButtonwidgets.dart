import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding; // Optional padding parameter

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.padding, // Padding is optional, default value is null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff216D8A), // Button background color
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Use provided padding or default
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          fontSize: 18, // Font size
          color: Color(0xffFFFFFF), // Text color
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
