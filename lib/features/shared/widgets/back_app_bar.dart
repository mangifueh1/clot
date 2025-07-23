import 'package:clot/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar backAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 60.h,
    automaticallyImplyLeading: false,
    scrolledUnderElevation: 0,
    title: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 35.w,
        height: 35.w,
        padding: EdgeInsets.only(left: 5.w),
        decoration: BoxDecoration(color: greyShade, shape: BoxShape.circle),
        child: Icon(Icons.arrow_back_ios, size: 15.r),
      ),
    ),
  );
}
