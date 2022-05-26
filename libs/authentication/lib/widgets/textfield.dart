import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label; 
  final bool obscure;
  const TextFieldWidget({Key? key, required this.label, required this.obscure}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
        // prefixIcon: const Icon(
        //   Icons.mail_outline_rounded,
        //   color: Colors.white,
        // ),
      ),
    );
  }
}