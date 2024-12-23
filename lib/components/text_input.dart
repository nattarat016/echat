import 'package:echat/datas/input_with_error_text.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  // final void Function(String)? onChanged;
  final InputWithErrorText inputWithErrorText;
  const TextInput(
      {super.key,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.hintText = "Enter somthing",
      // this.onChanged,
      required this.inputWithErrorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: (value){
        inputWithErrorText.valueText = value;
      },
      decoration: InputDecoration(
        hintText: hintText,
        // errorText: 'Invalid',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        errorText: inputWithErrorText.errorText,
      ),
    );
  }
}
