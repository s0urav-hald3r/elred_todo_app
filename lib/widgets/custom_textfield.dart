import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/input_validators.dart';
import '../config/size_configs.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.label,
    this.obsecuretext = false,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String validator;
  final String label;
  final bool obsecuretext;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: ((value) => Validators.choose(validator, value)),
      controller: controller,
      cursorColor: Colors.black38,
      obscureText: obsecuretext,
      style: GoogleFonts.quicksand(
          color: Colors.black87,
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.screenWidth! * 0.04),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: Colors.grey.shade100,
        filled: true,
        labelText: label,
        labelStyle: GoogleFonts.quicksand(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.screenWidth! * 0.035),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        isDense: true,
      ),
    );
  }
}
