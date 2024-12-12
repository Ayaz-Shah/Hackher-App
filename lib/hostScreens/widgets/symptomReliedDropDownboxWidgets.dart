import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomReliefDropdown extends StatefulWidget {
  final List<String> options;
  final TextEditingController? customReliefController;

  const SymptomReliefDropdown({
    Key? key,
    required this.options,
    this.customReliefController, // Pass controller from parent screen
  }) : super(key: key);

  @override
  _SymptomReliefDropdownState createState() => _SymptomReliefDropdownState();
}

class _SymptomReliefDropdownState extends State<SymptomReliefDropdown> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    // Set the default option to the item at index 1 if it exists
    selectedOption = widget.options.length > 1 ? widget.options[1] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container that wraps both Dropdown and TextField when 'none' is selected
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Shared background color for both
            borderRadius: BorderRadius.circular(8.0), // Same border radius
          ),
          child: Column(
            children: [
              // Dropdown for symptoms with hintText instead of labelText
              DropdownButtonFormField<String>(
                value: selectedOption,
                onChanged: (newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select relief option', // Use hintText without symptom label
                  hintStyle: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  border: InputBorder.none, // Remove default border
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Remove extra padding
                ),
                items: widget.options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Only show TextField below dropdown if 'none' is selected
              if (selectedOption == 'none') ...[
                // TextField will be part of the same container, directly below the dropdown
                TextField(
                  maxLines: 5,
                  controller: widget.customReliefController, // Use the passed controller
                  decoration: InputDecoration(
                    hintText: 'Write here',
                    hintStyle: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                    border: InputBorder.none, // Remove default border
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Remove extra padding
                  ),
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
