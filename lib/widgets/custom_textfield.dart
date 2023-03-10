import 'package:elred_todo_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    this.fillColor,
    this.lebelColor,
    this.textColor,
    this.cursorColor,
    this.errorTextColor = Colors.red,
  }) : super(key: key);

  final TextEditingController controller;
  final String validator;
  final String label;
  final bool obsecuretext;
  final Icon? suffixIcon;
  final Color? fillColor;
  final Color? lebelColor;
  final Color? textColor;
  final Color? cursorColor;
  final Color errorTextColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: Colors.black45)),
      child: TextFormField(
        validator: ((value) => Validators.choose(validator, value)),
        controller: controller,
        cursorColor: cursorColor ?? Colors.black38,
        obscureText: obsecuretext,
        style: GoogleFonts.quicksand(
            color: textColor ?? Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.screenWidth! * 0.04),
        decoration: InputDecoration(
          errorStyle: GoogleFonts.quicksand(
              color: errorTextColor,
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.screenWidth! * 0.04),
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: () =>
                      Provider.of<AuthController>(context, listen: false)
                          .toggleEye(),
                  child: suffixIcon)
              : null,
          fillColor: fillColor ?? Colors.grey.shade100,
          filled: true,
          labelText: label,
          labelStyle: GoogleFonts.quicksand(
              color: lebelColor ?? Colors.black54,
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
      ),
    );
  }
}
