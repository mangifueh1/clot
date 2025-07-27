import 'dart:convert';

import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/sources/image_services/image_picker_service.dart';
import 'package:clot/features/app/presentation/pages/settings/favorites/favorites_page.dart';
import 'package:clot/features/app/presentation/widgets/rounded_gray_container.dart';
import 'package:clot/features/shared/components/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(context, 2),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: getProfileImageBase64(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircleAvatar(
                    radius: 40.r,
                    child: CircularProgressIndicator(),
                  );
                }
                final imageBase64 = snapshot.data ?? '';
                return CircleAvatar(
                  radius: 40.r,
                  foregroundImage:
                      imageBase64.isNotEmpty
                          ? MemoryImage(base64Decode(imageBase64))
                          : null,
                  child:
                      imageBase64.isEmpty
                          ? Icon(Icons.person, size: 30.r, color: Colors.grey)
                          : null,
                );
              },
            ),
            30.customH,
            RoundedGrayContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // 'John Doe',
                          FirebaseAuth.instance.currentUser!.displayName ??
                              'John Doe',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.customH,
                        Text(
                          FirebaseAuth.instance.currentUser!.email ??
                              'johndoe@gmail.com',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Edit>',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: mainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            20.customH,
            buildSettingItem(
              'My Favorites',
              () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => FavoritesPage()),
              ),
            ),
            buildSettingItem('Support', () {}),
            150.customH,
            Center(
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/signInScreen');
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RoundedGrayContainer buildSettingItem(String label, void Function()? onTap) {
    return RoundedGrayContainer(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 14.sp)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
