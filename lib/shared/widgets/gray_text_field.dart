import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GrayTextField extends StatelessWidget {
  const GrayTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText!,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        suffixIcon: Icon(suffixIcon, size: 20.r),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Icon(prefixIcon, size: 20.r),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
