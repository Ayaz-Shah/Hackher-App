import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomImageButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback onTap; // Callback function for tap action

  CustomImageButton({
    required this.imageAsset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle the tap action here
      child: SizedBox(
        width: 81.6, // Total width of the widget
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevent overflow
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container for the image with specified width, height, and border
            Container(
              width: 81.6, // Set the container size here
              height: 81.6, // Match width to keep it square
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Optional: Adjust radius
                border: Border.all(
                  color: const Color(0xFFFFD5C3), // Border color
                  width: 1.55,
                ),
              ),
              child: Center(
                child: Container(
                  width: 42.49, // Image width
                  height: 42.49, // Image height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset), // Image path
                      fit: BoxFit.cover, // Adjust the image fit
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8), // Adjust spacing between container and text
            // Text label below the image
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.9,
                  color: Colors.black, // Text color
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
