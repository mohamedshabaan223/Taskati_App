import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key , required this.controller , this.validator , this.hintlabel ,required this.labelText ,
   this.keyValue});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintlabel;
  final String labelText;
  final Key? keyValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      key:keyValue ,
      controller: controller ,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUnfocus,
      decoration: InputDecoration(
        label:Text(labelText) ,
        hintText: hintlabel ,
        hintStyle: TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2 , color: Colors.deepPurple)
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2 , color: Colors.deepPurple)
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2 , color: Colors.deepPurple)
        ), 
      ),
    );
  }
}