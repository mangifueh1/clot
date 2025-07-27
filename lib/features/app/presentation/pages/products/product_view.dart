import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/date_formatter.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/like_services.dart';
import 'package:clot/features/app/data/sources/services/product_service.dart';
import 'package:clot/features/app/presentation/riverpod/int_provider.dart';
import 'package:clot/features/app/presentation/riverpod/like_provider.dart';
import 'package:clot/features/app/presentation/widgets/circular_border_rectangle.dart';
import 'package:clot/features/app/presentation/widgets/like_button.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key, required this.id});

  final int id;

  @override
  ConsumerState<ProductView> createState() => _ProductViewConsumerState();
}

class _ProductViewConsumerState extends ConsumerState<ProductView> {
  ProductModel? product;
  bool? isFavorite;

  void getProductInfo() async {
    product = await getSingleProduct(widget.id);
    isFavorite = await getLikedProducts().then(
      (x) => x.contains(product?.id ?? 0),
    );
    ref.read(productPriceProvider.notifier).state =
        product?.price?.toInt() ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getProductInfo();
  }

  @override
  Widget build(BuildContext context) {
    // int quantity = ref.watch(productQuantityProvider);
    int initialPrice = ref.watch(productPriceProvider);
    int total = ref.watch(productTotalProvider);
    return Scaffold(
      appBar:
          product == null
              ? backAppBar(context: context)
              : backAppBar(
                context: context,
                actions: [
                  LikeButton(
                    isFavorite: isFavorite!,
                    color: greyShade,
                    productId: product?.id ?? 0,
                  ),
                ],
              ),
      body:
          product == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.customH,
                        SizedBox(
                          width: double.infinity,
                          height: 200.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product?.images?.length ?? 0,

                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            itemBuilder:
                                (context, index) => Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  width: 150.h,
                                  height: 180.h,
                                  color: greyShade,
                                  child: Image.network(
                                    product?.images?[index].toString() ?? "",
                                  ),
                                ),
                          ),
                        ),
                        20.customH,
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            product?.title.toString() ?? "",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        10.customH,
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '\$$initialPrice',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: mainColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        20.customH,
                        CircularBorderRectangle(
                          color: greyShade,
                          leftSide: 'Quantity',
                          // number: quantity,
                        ),
                        25.customH,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            product?.description.toString() ?? "",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        20.customH,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            'Shipping & Returns',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        5.customH,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            product?.returnPolicy.toString() ?? "",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        20.customH,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        10.customH,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            "${product?.rating} Ratings",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 300.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15.w,
                                  right: 15.w,
                                  top: 20.h,
                                ),
                                child: Text(
                                  '${product?.reviews?.length} reviews',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder:
                                      (context, index) => Container(
                                        width: double.infinity,
                                        height: 100.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                          vertical: 10.h,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${product?.reviews?[index]['reviewerName']}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${product?.reviews?[index]['comment']}',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey,
                                                // fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              timeAgo(
                                                product?.reviews?[index]['date'] ??
                                                    DateTime.now().toString(),
                                              ),
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey,
                                                // fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        100.customH,
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: double.infinity,
                      height: 50.h,
                      child: CircularBorderRectangle(
                        // initialPrice: initialPrice,
                        leftSide: '\$$total',
                        color: mainColor,
                        leftColor: Colors.white,
                        leftWeight: FontWeight.bold,
                        rightSide: [
                          Text(
                            'Add to Bag',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
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
