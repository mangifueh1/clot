import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            // color: Colors.grey,
            fontSize: 12.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Image.asset('assets/images/search.png'),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),
        ),
        style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp),
      ),
    );
  }
}
