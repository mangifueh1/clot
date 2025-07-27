import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/presentation/widgets/rounded_gray_container.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
import 'package:clot/features/shared/widgets/custom_confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageConsumerState();
}

class _CartPageConsumerState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context: context, title: "Cart"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Remove all',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                10.customH,
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => CartItem(),
                  ),
                ),
                220.customH,
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _leftRightText("Subtotal", "\$200"),
                _leftRightText("Shipping Fee", "\$0.00"),
                _leftRightText("Total", "\$200"),
                50.customH,
                CustomConfirmButton(
                  title: 'Checkout',
                  color: mainColor,
                  onTap: () {},
                ),
                20.customH,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftRightText(String left, String right) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedGrayContainer(
      child: Row(
        children: [
          Container(width: 55.h, height: 55.h, color: greyShade),
          SizedBox(
            height: 50.h,
            width: 100.h,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mens Jacket',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'Quantity - ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$200',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              10.customH,
              Container(
                // width: 15.w,
                // height: 15.w,
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                  size: 17.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

