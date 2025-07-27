import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/capitalize_extension.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/catergory_service.dart';
import 'package:clot/features/app/data/sources/services/product_service.dart';
import 'package:clot/features/app/presentation/widgets/product_card.dart';
import 'package:clot/features/shared/components/bottom_nav_bar.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
import 'package:clot/features/shared/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key,});

  // final String category;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModel>? product;
  final TextEditingController _searchControl = TextEditingController();

  void getResults() async {
    product = await getSearchedProducts(_searchControl.text);
    setState(() {});
  }

  @override
  void initState() {
    // getCategorizedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(context, 1),
        // appBar: backAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.customH,
                SizedBox(
                  width: double.infinity,
                  child: CustomSearchBar(searchControl: _searchControl),
                ),
                20.customH,
                SizedBox(
                  // height: 10.h,
                  child: Text(
                    '19 results found',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(left: 5.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 270.h,
                        ),
                        itemCount: product?.length ?? 0,
                        itemBuilder: (context, index) {
                          return VerticalProductCard(product: product, index: index);
                        },
                      ),
                    ),
              ],
            ),
            // product == null
            //     ? Center(child: CircularProgressIndicator())
            //     : Column(
            //       children: [
            //         SizedBox(
            //           width: double.infinity,
            //           // height: ,
            //           child: Text(
            //             '${widget.category.capitalizeFirst()} (${product!.length})',
            //             style: TextStyle(
            //               fontSize: 15.sp,
            //               fontWeight: FontWeight.w600,
            //               // fontFamily: 'Poppins',
            //             ),
            //           ),
            //         ),
            //         10.customH,
            //         Expanded(
            //           child: GridView.builder(
            //             padding: EdgeInsets.only(left: 5.w),
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               mainAxisExtent: 270.h,
            //             ),
            //             itemCount: product!.length,
            //             itemBuilder: (context, index) {
            //               return VerticalProductCard(product: product, index: index);
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
          ),
        ),
      ),
    );
  }
}
