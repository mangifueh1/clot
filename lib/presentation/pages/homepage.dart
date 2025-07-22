import 'package:clot/core/config.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/shared/widgets/custom_search_bar.dart';
import 'package:clot/shared/widgets/catergory_card.dart';
import 'package:clot/shared/widgets/product_card.dart';
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
  final dio = Dio();
  var categoriesList = [];
  var productList = [];
  var classicProductList = [];

  void getCategories() async {
    try {
      Response response;
      response = await dio.get("${baseUrl}categories");
      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          List<dynamic> allList = response.data;
          categoriesList = allList.take(5).toList();
        });
        // print(categoriesList);
      }
      // print(response.data);
    } catch (e) {
      print("Error: $e");
    }
  }


  void getProducts() async {
    try {
      Response response;
      response = await dio.get("${baseUrl}products");
      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          List<dynamic> allList = response.data;
          productList = allList.take(10).toList();
        });
        // print(productList);
      }
      // print(response.data);
    } catch (e) {
      print("Error: $e");
    }
  }
  void getClassicProducts() async {
    try {
      Response response;
      response = await dio.get("${baseUrl}products/?title=sleek");
      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          List<dynamic> allList = response.data;
          classicProductList = allList.take(10).toList();
        });
        // print(productList);
      }
      // print(response.data);
    } catch (e) {
      print("Error: $e");
    }
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
    getCategories();
    getProducts();
    getClassicProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 8.0.h),
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
              _buildSectionHeader('Top Selling', showSeeAll: true),
              12.customH,
              _buildProductList(true, productList, classicProductList),
              20.customH,

              // --- New In Section ---
              _buildSectionHeader('New In', showSeeAll: true),
              12.customH,
              _buildProductList(false, productList, classicProductList),
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
          width: 35.w,
          height: 35.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!, width: 2.r),
            image: const DecorationImage(
              image: NetworkImage(
                'https://placehold.co/50x50/aabbcc/ffffff?text=User', // Placeholder image
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Men dropdown
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Men',
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black54,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500, // Medium weight
                fontSize: 14.sp,
              ),
              onChanged: (String? newValue) {
                // Handle dropdown change
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Selected: $newValue')));
              },
              items:
                  <String>['Men', 'Women'].map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ),
        ),
        // Shopping Bag Icon
        InkWell(
          onTap: () {
            _showSnackBar('Shopping bag tapped!');
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  Theme.of(
                    context,
                  ).colorScheme.primary, // Using primary color for consistency
              // borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 20.r,
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

  Widget _buildProductList(bool isTopSelling, List<dynamic> topSelling, List<dynamic> classic) {
    return SizedBox(
      height: isTopSelling ? 280.h : 120.h, // Adjust height based on section
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topSelling.length,
        itemBuilder: (context, index) {
          final product =isTopSelling?  topSelling: classic;
          if (isTopSelling) {
            return VerticalProductCard(product: product, index: index);
          } else {
            return HorizontalProductCard(product: product, index: index);
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
