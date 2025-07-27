import 'package:clot/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedGrayContainer extends StatelessWidget {
  const RoundedGrayContainer({super.key, required this.child, this.onTap});

  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        // height: 70.h,
        decoration: BoxDecoration(
          color: greyShade,
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 2.h),
        child: child,
      ),
    );
  }
}
