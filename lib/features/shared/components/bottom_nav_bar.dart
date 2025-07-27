import 'package:clot/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBottomNavigationBar(BuildContext context, int selectedIndex) {
  return Container(
    height: 50.h,
    decoration: BoxDecoration(
      color: Colors.white,
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.1),
      //     spreadRadius: 0,
      //     blurRadius: 10,
      //     offset: const Offset(0, -5),
      //   ),
      // ],
      // borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    child: ClipRRect(
      // borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          if (value == 0) {
            Navigator.pushReplacementNamed(context, '/homepage');
          }
          if (value == 1) {
            Navigator.pushReplacementNamed(context, '/search');
          }
          if (value == 2) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
        selectedItemColor:
            Theme.of(
              context,
            ).colorScheme.primary, // Primary color for selected item
        unselectedItemColor: Colors.black,

        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 20.h,
              height: 20.h,
              child: Image.asset(
                'assets/images/home.png',
                color: selectedIndex == 0 ? mainColor : Colors.black,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 20.h,
              height: 20.h,
              child: Image.asset(
                'assets/images/search.png',
                color: selectedIndex == 1 ? mainColor : Colors.black,
              ),
            ),
            label: 'Search',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat_bubble_outline, size: 25.r),
          //   label: 'Chat',
          // ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/person.png',
              color: selectedIndex == 2 ? mainColor : Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    ),
  );
}

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
