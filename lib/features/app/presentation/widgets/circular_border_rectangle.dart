import 'package:clot/config/colors.dart';
import 'package:clot/features/app/presentation/riverpod/int_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularBorderRectangle extends ConsumerStatefulWidget {
  CircularBorderRectangle({
    super.key,
    this.color,
    required this.leftSide,
    this.rightSide,
    this.leftColor,
    // this.number,
    this.leftWeight,
  });

  final Color? color;
  final Color? leftColor;
  final String leftSide;
  final FontWeight? leftWeight;
  // int? number;
  final List<Widget>? rightSide;

  @override
  ConsumerState<CircularBorderRectangle> createState() =>
      _CircularBorderRectangleConsumerState();
}

class _CircularBorderRectangleConsumerState
    extends ConsumerState<CircularBorderRectangle> {
  @override
  Widget build(BuildContext context) {
    // int price = ref.watch(productPriceProvider);
    int quantity = ref.watch(productQuantityProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          Text(
            widget.leftSide,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: widget.leftWeight ?? FontWeight.w500,
              color: widget.leftColor ?? Colors.black,
            ),
          ),
          Spacer(),
          Row(
            children:
                widget.rightSide ??
                [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 1) {
                          ref.read(productQuantityProvider.notifier).state =
                              quantity - 1;
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 17.r,
                      backgroundColor: mainColor,
                      child: Text('-', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: double.maxFinite,
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(productQuantityProvider.notifier).state =
                          quantity + 1;

                      // int newPrice = price * quantity;
                      // ref.read(productPriceProvider.notifier).state = newPrice;
                    },
                    child: CircleAvatar(
                      radius: 17.r,
                      backgroundColor: mainColor,
                      child: Text('+', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }
}
