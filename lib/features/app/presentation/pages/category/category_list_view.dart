import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/capitalize_extension.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/sources/services/catergory_service.dart';
import 'package:clot/features/app/presentation/pages/category/category_view.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<dynamic> categories = [];
  String selectedCategory = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    categories = await getCategoriesFromApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              // height: ,
              child: Text(
                'Shop by Categories',
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Poppins',
                ),
              ),
            ),
            5.customH,
            categories.isEmpty
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      String selectedCategory = categories[index].toString();
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/categoryView', arguments: selectedCategory),
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          margin: EdgeInsets.only(top: 7.h),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: greyShade,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: mainColor,
                              ),
                              20.customW,
                              Text(
                                categories[index].toString().capitalizeFirst(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            10.customH,
          ],
        ),
      ),
    );
  }
}
