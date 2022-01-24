import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function(String value)? onChanged;

  const InputWidget(
      {Key? key,
      this.onChanged,
      this.suffixIcon,
      this.hintText,
      this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(32.0),
      ),
      padding: const EdgeInsets.only(
        right: 24.0,
        left: 24.0,
      ),
      child: TextFormField(
        obscureText: obscureText!,
        onChanged: (value) {
          onChanged!(value);
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon == null
              ? null
              : Icon(
                  suffixIcon,
                  color: const Color.fromRGBO(105, 108, 121, 1),
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(124, 124, 124, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
