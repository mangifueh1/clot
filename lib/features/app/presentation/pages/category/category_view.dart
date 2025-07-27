import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/capitalize_extension.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/catergory_service.dart';
import 'package:clot/features/app/presentation/widgets/product_card.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel>? product;

  void getCategorizedData() async {
    product = await getCategorizedProductsFromApi(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getCategorizedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child:
            product == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      // height: ,
                      child: Text(
                        '${widget.category.capitalizeFirst()} (${product!.length})',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          // fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    10.customH,
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(left: 5.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 270.h,
                        ),
                        itemCount: product!.length,
                        itemBuilder: (context, index) {
                          return VerticalProductCard(product: product, index: index);
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
