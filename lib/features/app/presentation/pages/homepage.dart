import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/catergory_service.dart';
import 'package:clot/features/app/data/sources/services/product_service.dart';
import 'package:clot/features/app/presentation/pages/category/category_list_view.dart';
import 'package:clot/features/app/presentation/pages/category/category_view.dart';
import 'package:clot/features/shared/components/bottom_nav_bar.dart';
import 'package:clot/features/app/presentation/widgets/catergory_card.dart';
import 'package:clot/features/app/presentation/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<ProductModel>? product;
  List<ProductModel>? horizProduct;
  // final dio = Dio();
  List<dynamic> categoriesList = [];
  String selectedCategory = '';

  void getCategories() async {
    try {
      categoriesList = await getCategoriesFromApi();
      setState(() {});
    } catch (e) {
      print("Error: $e");
      setState(() {
        categoriesList = [];
      });
    }
  }

  void getTopLaptops() async {
    product = await getProducts('laptops');
    setState(() {});
  }

  void getBeautyProducts() async {
    horizProduct = await getProducts('beauty');
    setState(() {});
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   // In a real app, you would navigate to different pages here
  //   if (index == 1) {
  //     Navigator.pushNamed(context, '/search');
  //   }
  // }

  @override
  void initState() {
    super.initState();

    getCategories();
    getTopLaptops();
    getBeautyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body:
            product == null || horizProduct == null || categoriesList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      // horizontal: 17.0.w,
                      vertical: 8.0.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Top Bar: Profile, Dropdown, Cart ---
                        5.customH,
                        _buildTopBar(),
                        20.customH,

                        // --- Search Bar ---
                        // CustomSearchBar(),
                        20.customH,

                        // --- Categories Section ---
                        _buildSectionHeader(
                          'Categories',
                          CategoryListView(),
                          showSeeAll: true,
                        ),
                        12.customH,
                        _buildCategories(categoriesList),
                        20.customH,

                        // --- Top Selling Section ---
                        _buildSectionHeader(
                          'Top Selling Computers',
                          CategoryView(category: 'laptops'),
                          showSeeAll: true,
                        ),
                        12.customH,
                        _buildProductList(true, product!, horizProduct!),
                        20.customH,

                        // --- New In Section ---
                        _buildSectionHeader(
                          'New In Beauty Products',
                          CategoryView(category: 'beauty'),
                          showSeeAll: true,
                        ),
                        12.customH,
                        _buildProductList(false, product!, horizProduct!),
                        20.customH,
                      ],
                    ),
                  ),
                ),
        bottomNavigationBar: buildBottomNavigationBar(context, 0),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User Profile Image
          Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyShade, width: 2.r),
              // image: const DecorationImage(
              //   image: NetworkImage(
              //     'https://placehold.co/50x50/aabbcc/ffffff?text=User', // Placeholder image
              //   ),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          // Men dropdown
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            width: 100.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Image.asset('assets/images/logo.png', color: mainColor),
          ),
          // Shopping Bag Icon
          InkWell(
            onTap: () {
              showSnackBar('Shopping bag tapped!', context);
            },
            child: Container(
              padding: EdgeInsets.all(9.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor, // Using primary color for consistency
                // borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 15.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    Widget route, {
    bool showSeeAll = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600, // SemiBold
            ),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => route),
                );
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500, // Medium
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategories(List<dynamic>? categories) {
    if (categories == null || categories.isEmpty) {
      return SizedBox(
        height: 100.h,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return SizedBox(
      height: 35.h, // Height for the category row
      child:
          categories.isEmpty
              ? SizedBox(child: Center(child: CircularProgressIndicator()))
              : SizedBox(
                height: 50.h,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.take(5).length,
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  itemBuilder: (context, index) {
                    String selectedCategory = categories[index].toString();
                    return CatergoryCard(
                      categories: categories,
                      index: index,
                      selectedCategory: selectedCategory,
                    );
                  },
                ),
              ),
    );
  }

  Widget _buildProductList(
    bool isTopSelling,
    List<ProductModel> topSelling,
    List<ProductModel> classic,
  ) {
    return SizedBox(
      height: isTopSelling ? 280.h : 120.h, // Adjust height based on section
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        itemBuilder: (context, index) {
          final product = topSelling;
          if (isTopSelling) {
            return VerticalProductCard(product: product, index: index);
          } else {
            return HorizontalProductCard(
              horizProduct: horizProduct,
              index: index,
            );
          }
        },
      ),
    );
  }
}
