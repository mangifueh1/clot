import 'package:clot/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.searchControl});

  final TextEditingController searchControl;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      decoration: BoxDecoration(
        color: greyShade,
        borderRadius: BorderRadius.circular(30.0.r),
      ),
      child: TextField(
        controller: widget.searchControl,
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
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),
        ),
        style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp),
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              suffixIcon = IconButton(
                icon: Icon(Icons.clear, size: 15.r),
                onPressed: () {
                  widget.searchControl.clear();
                  setState(() {
                    suffixIcon = null;
                  });
                },
              );
            });
          } else {
            setState(() {
              suffixIcon = null;
            });
          }
        },
      ),
    );
  }
}
