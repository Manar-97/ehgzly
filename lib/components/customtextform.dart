import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator; // ✅ عشان الفاليديشين
  final bool obscureText; // ✅ عشان الباسورد
  final TextInputType keyboardType; // ✅ نوع الكيبورد

  const CustomTextForm({
    super.key,
    required this.hintText,
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText = false, // الافتراضي مش مخفي
    this.keyboardType = TextInputType.text,
    required this.suffixIcon, // الافتراضي نص
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.white),
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // ✅
        keyboardType: keyboardType, // ✅
        validator: validator, // ✅
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          hintText: hintText,
          suffixIcon: Icon(suffixIcon, color: Colors.grey[600]),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }
}
