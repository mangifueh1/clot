import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/presentation/pages/products/product_view.dart';
import 'package:clot/features/app/presentation/riverpod/like_provider.dart';
import 'package:clot/features/app/presentation/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalProductCard extends ConsumerStatefulWidget {
  const HorizontalProductCard({
    super.key,
    required this.horizProduct,
    required this.index,
  });

  final List<ProductModel>? horizProduct;
  final int index;

  @override
  ConsumerState<HorizontalProductCard> createState() =>
      _HorizontalProductCardConsumerState();
}

class _HorizontalProductCardConsumerState
    extends ConsumerState<HorizontalProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.w, // Wider card for New In section
      margin: EdgeInsets.only(
        right: 10.0.w,
        bottom: 11.h,
        top: 11.h,
        left: 10.w,
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
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12.r),
                ),
                child:
                    widget.horizProduct == null
                        ? Center(child: CircularProgressIndicator())
                        : Image.network(
                          widget.horizProduct?[widget.index].thumbnail ?? "",
                          height: 120.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 120.h,
                              width: 100.w,
                              color: Colors.grey[200],
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
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductView(
                              id: widget.horizProduct?[widget.index].id ?? 1,
                            ),
                      ),
                    ),
                child: SizedBox(
                  width: 150.w,
                  child: Padding(
                    padding: EdgeInsets.all(10.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.horizProduct == null
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                              widget.horizProduct?[widget.index].title
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400, // Medium
                                fontSize: 14.sp,
                              ),
                              maxLines: 2,

                              // softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                        2.customH,
                        widget.horizProduct == null
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                              widget.horizProduct?[widget.index].price
                                      .toString() ??
                                  "",
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
              ),
            ],
          ),
          Positioned(
            right: 0.0,
            child: LikeButton(
              isFavorite: ref.watch(likeProvider),
              productId: widget.horizProduct?[widget.index].id ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalProductCard extends ConsumerStatefulWidget {
  const VerticalProductCard({
    super.key,
    required this.product,
    required this.index,
  });

  final List<ProductModel>? product;
  final int index;

  @override
  ConsumerState<VerticalProductCard> createState() =>
      _VerticalProductCardConsumerState();
}

class _VerticalProductCardConsumerState
    extends ConsumerState<VerticalProductCard> {
  bool isFavorite = false;

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
                    widget.product == null
                        ? Center(child: CircularProgressIndicator())
                        : Image.network(
                          widget.product?[widget.index].thumbnail ?? "",
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
                child: LikeButton(
                  isFavorite: ref.watch(likeProvider),
                  productId: widget.product?[widget.index].id ?? 0,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProductView(
                          id: widget.product?[widget.index].id ?? 1,
                        ),
                  ),
                ),
            child: Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.product == null
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                        widget.product?[widget.index].title.toString() ?? "",
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
                      widget.product == null
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                            widget.product?[widget.index].price.toString() ??
                                "",
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
          ),
        ],
      ),
    );
  }
}
