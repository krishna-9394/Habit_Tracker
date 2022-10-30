import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home_Model.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixData;
  final bool obscureText;
  final Function(String)? onChanged;

  const TextFieldWidget({super.key,
    required this.hintText,
    required this.prefixIconData,
    this.suffixData,
    this.obscureText = false,
    this.onChanged});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    return TextField(
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 15,
        color: Global.mediumBlue,
      ),
      cursorColor: Global.mediumBlue,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Global.mediumBlue,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Global.mediumBlue),
          borderRadius: BorderRadius.circular(10)
      ),
        suffixIcon: GestureDetector(
          onTap: (){
            model.isVisible = !model.isVisible;
          },
          child: Icon(suffixData,
              size: 18,
              color: Global.mediumBlue,
            ),
        ),
        labelStyle: TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
      )
    );
  }
}


class Global {
  static const Color white = const Color(0xffffffff);
  static const Color mediumBlue = const Color(0xff4A64FE);
}

