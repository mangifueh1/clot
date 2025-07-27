import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/capitalize_extension.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/presentation/pages/category/category_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatergoryCard extends StatelessWidget {
  const CatergoryCard({
    super.key,
    required this.categories,
    required this.index,
    required this.selectedCategory,
  });

  final List<dynamic> categories;
  final String selectedCategory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CategoryView(category: selectedCategory),
            ),
          );
        },
        child: Container(
          // width: 100.w,
          height: 10.h,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 2.r, backgroundColor: Colors.white),
              10.customW,
              Text(
                categories[index].toString().capitalizeFirst(),
                style: TextStyle(
                  fontSize: 10.sp,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
