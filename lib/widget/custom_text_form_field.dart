import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key , required this.controller , this.validator , this.hintlabel  ,
   this.maxLines, this.readOnly, this.suffixIcon , this.onTap, this.colorHintText});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintlabel;
  final int? maxLines;
  final bool? readOnly;
  final Widget? suffixIcon;
  final  void Function()? onTap;
  final Color? colorHintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly??false,
      controller: controller ,
      validator: validator ?? (value){
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
       suffixIcon: suffixIcon,
        hintText: hintlabel ,
        hintStyle: TextStyle(color: colorHintText),
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