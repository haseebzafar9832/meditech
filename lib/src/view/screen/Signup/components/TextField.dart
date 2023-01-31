import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  String labeltext;
  TextEditingController controller;
  IconData? icon;
  bool? obsecure;
  Function()? onPressed;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  BorderSide borderSide;
  Color? fillColor;
  IconData? imgIcon;
  Function()? onpressedImg;
  TextInputType? keyboardType;
  bool focus;
  Widget? prefix;
  bool readOnly;
  Function()? onTap;
  TextStyle? labelStyle;
  LoginTextField({
    required this.labeltext,
    required this.controller,
    this.icon,
    this.obsecure,
    this.onChanged,
    this.onPressed,
    required this.validator,
    required this.borderSide,
    this.fillColor,
    this.imgIcon,
    this.onpressedImg,
    this.focus = false,
    this.keyboardType,
    this.prefix,
    this.readOnly = false,
    this.onTap,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      onTap: onTap,
      keyboardType: keyboardType,
      validator: validator,
      autofocus: focus,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.black),
      onChanged: onChanged,
      obscureText: obsecure!,
      decoration: InputDecoration(
        hintText: labeltext,
        hintStyle: labelStyle != null
            ? labelStyle
            : TextStyle(
                fontSize: 13,
                overflow: TextOverflow.visible,
                color: Colors.grey.withOpacity(0.8),
              ),
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 7.0, 20.0, 10.0),
        filled: true,
        prefixIcon: prefix,
        suffixIcon: icon != null
            ? InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onPressed,
                child: Icon(
                  icon,
                  color: Colors.grey.withOpacity(0.7),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(06),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(06),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(06.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(06.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(06.0),
        ),
      ),
      controller: controller,
    );
  }
}
