import 'package:flutter/material.dart';

class AuthTextFieldWidgetB extends StatelessWidget {

  final TextEditingController textEditingController;
  final String labelText;
  final IconData prefixIcon;
  final bool isPasswordHidden;
  final IconData? suffixIcon;
  final void Function()? onSuffixPressed;
  final String? Function(String?)? validatorFunction;

  const AuthTextFieldWidgetB({super.key,
    required this.textEditingController,
    required this.labelText,
    required this.prefixIcon,
    this.isPasswordHidden = false,
    this.suffixIcon,
    this.onSuffixPressed,
    this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText: isPasswordHidden,
      controller: textEditingController,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: Colors.deepPurple,),
          suffixIcon: InkWell(
            onTap: onSuffixPressed,
              child: Icon(suffixIcon, color: Colors.red,)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      validator: validatorFunction
    );
  }
}
