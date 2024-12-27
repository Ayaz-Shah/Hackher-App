import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool isObscure;
  final bool isPassword;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final bool? enabled; // Added enabled parameter

  const CustomTextFormField({
    Key? key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.isObscure = false,
    this.isPassword = false,
    this.controller,
    this.labelStyle,
    this.labelColor,
    this.onEditingComplete,
    this.validator,
    this.enabled = true, // Default is true, meaning the text field is enabled
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _isObscured,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validator,
        enabled: widget.enabled, // Use the enabled parameter
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.labelStyle ??
              GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: widget.labelColor ?? const Color(0xff222222),
              ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
            widget.prefixIcon,
            color: const Color(0xff216D8A),
          )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null,
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xffF4DCB2)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xffF4DCB2)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xffFFFFFF)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xffF4DCB2)),
          ),
          filled: true,
          fillColor: Colors.pink[50],
        ),
      ),
    );
  }
}
