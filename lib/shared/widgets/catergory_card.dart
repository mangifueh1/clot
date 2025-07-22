import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatergoryCard extends StatelessWidget {
  const CatergoryCard({
    super.key,
    required this.categories,
    required this.index,
  });

  final List<dynamic> categories;
  final int index;

  @override
  Widget build(BuildContext context) {
    final category = categories[index];
    return Padding(
      padding: EdgeInsets.only(right: 14.0.w),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              image:
                  category['image'] != null
                      ? DecorationImage(
                        image: NetworkImage(category['image']),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 65.w,
            child: Text(
              category['name'] ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
