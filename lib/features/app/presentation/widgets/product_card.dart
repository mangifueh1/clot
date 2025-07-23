import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    super.key,
    required this.horizProduct,
    required this.index,
  });

  final List<ProductModel>? horizProduct;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w, // Wider card for New In section
      margin: EdgeInsets.only(
        right: 13.0.w,
        bottom: 11.h,
        top: 11.h,
        left: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: greyShade,
            spreadRadius: 11,
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
            child:
                horizProduct == null
                    ? Center(child: CircularProgressIndicator())
                    : Image.network(
                      horizProduct?[index].images?.first ?? "",
                      height: 120.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120.h,
                          width: 100.w,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        );
                      },
                    ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  horizProduct == null
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                        horizProduct?[index].title.toString() ?? "",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400, // Medium
                          fontSize: 14.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  2.customH,
                  horizProduct == null
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                        horizProduct?[index].price.toString() ?? "",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600, // SemiBold
                          fontSize: 14.sp,
                        ),
                      ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(2.0.r),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 20.sp,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({
    super.key,
    required this.product,
    required this.index,
  });

  final List<ProductModel>? product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 5.0.w, bottom: 5.h),
      decoration: BoxDecoration(
        color: greyShade,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child:
                    product == null
                        ? Center(child: CircularProgressIndicator())
                        : Image.network(
                          product?[index].images?.first ?? "",
                          height: 180.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180.h,
                              color: greyShade,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 20.r,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product == null
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                      product?[index].title.toString() ?? "",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400, // Medium
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    product == null
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                          product?[index].price.toString() ?? "",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600, // SemiBold
                            fontSize: 14.sp,
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
