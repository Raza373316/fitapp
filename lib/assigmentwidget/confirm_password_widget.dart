import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final IconData prefixIcon;
  final bool isPasswordHidden;
  final IconData? suffixIcon;
  final void Function()? onTap;
  final void Function()? onSuffixPressed;
  final String? Function(String?)? validatorFunction;

  const CustomWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.prefixIcon,
    this.isPasswordHidden = false,
    this.onTap,
    this.suffixIcon,
    this.onSuffixPressed,
    this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: isPasswordHidden,
      validator: validatorFunction,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),

        prefixIcon: Icon(prefixIcon, color: Colors.teal),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon, color: Colors.teal),
          onPressed: onSuffixPressed,
        )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.teal),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1),

        ),
      ),
      onTap: onTap,
    );
  }
}





