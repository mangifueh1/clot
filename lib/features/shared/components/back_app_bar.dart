import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar backAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return title == null
      ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 35.w,
                height: 35.w,
                padding: EdgeInsets.only(left: 5.w),
                decoration: BoxDecoration(
                  color: greyShade,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios, size: 15.r),
              ),
            ),
          ],
        ),
        actions: actions,
        actionsPadding: EdgeInsets.only(right: 10.w),
      )
      : AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60.h,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 35.w,
                height: 35.w,
                padding: EdgeInsets.only(left: 5.w),
                decoration: BoxDecoration(
                  color: greyShade,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios, size: 15.r),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.customW,
          ],
        ),
        actions: actions,
        actionsPadding: EdgeInsets.only(right: 10.w),
      );
}
