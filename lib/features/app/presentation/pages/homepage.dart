import 'package:clot/config/colors.dart';
import 'package:clot/config/config.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/product_service.dart';
import 'package:clot/features/shared/widgets/custom_search_bar.dart';
import 'package:clot/features/app/presentation/widgets/catergory_card.dart';
import 'package:clot/features/app/presentation/widgets/product_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // For the bottom navigation bar
  List<ProductModel>? product;
  List<ProductModel>? horizProduct;
  final dio = Dio();
  var categoriesList = [
    {"name": "Bags", "image": ""},
    {"name": "Books", "image": ""},
    {"name": "Accessories", "image": ""},
  ];

  void getCategories() async {
    try {} catch (e) {
      print("Error: $e");
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // In a real app, you would navigate to different pages here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigated to index $_selectedIndex')),
    );
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getTopLaptops();
    getBeautyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          product == null
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.0.w,
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
                      CustomSearchBar(),
                      20.customH,

                      // --- Categories Section ---
                      _buildSectionHeader('Categories', showSeeAll: true),
                      12.customH,
                      _buildCategories(categoriesList),
                      20.customH,

                      // --- Top Selling Section ---
                      _buildSectionHeader(
                        'Top Selling Computers',
                        showSeeAll: true,
                      ),
                      12.customH,
                      _buildProductList(true, product!, horizProduct!),
                      20.customH,

                      // --- New In Section ---
                      _buildSectionHeader(
                        'New In Beauty Products',
                        showSeeAll: true,
                      ),
                      12.customH,
                      _buildProductList(false, product!, horizProduct!),
                      20.customH,
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTopBar() {
    return Row(
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
          child: Image.asset('assets/images/logo.png', color: mainColor),
        ),
        // Shopping Bag Icon
        InkWell(
          onTap: () {
            _showSnackBar('Shopping bag tapped!');
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
    );
  }

  Widget _buildSectionHeader(String title, {bool showSeeAll = false}) {
    return Row(
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
              _showSnackBar('See All $title tapped!');
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
    );
  }

  Widget _buildCategories(List<dynamic> categories) {
    return SizedBox(
      height: 100.h, // Height for the category row
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CatergoryCard(categories: categories, index: index);
        },
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
        itemBuilder: (context, index) {
          final product = topSelling;
          if (isTopSelling) {
            return VerticalProductCard(product: product, index: index);
          } else {
            return HorizontalProductCard(horizProduct: classic, index: index);
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor:
              Theme.of(
                context,
              ).colorScheme.primary, // Primary color for selected item
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed, // Ensures all items are visible
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 25.r),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none, size: 25.r),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline, size: 25.r),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 25.r),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
