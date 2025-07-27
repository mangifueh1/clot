import 'dart:convert';

import 'package:clot/config/colors.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:clot/features/app/data/sources/image_services/image_picker_service.dart';
import 'package:clot/features/app/presentation/riverpod/image_provider.dart';
import 'package:clot/features/shared/widgets/custom_confirm_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/gray_text_field.dart';

class AboutYouScreen extends ConsumerStatefulWidget {
  const AboutYouScreen({super.key});

  @override
  ConsumerState<AboutYouScreen> createState() => _AboutYouScreenConsumerState();
}

class _AboutYouScreenConsumerState extends ConsumerState<AboutYouScreen> {
  String selectedGender = 'Men';
  final TextEditingController _usernameController = TextEditingController();

  Future<void> setupUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('usernames')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            // "username": _usernameController.text,
            "gender": selectedGender,
            "profilePhoto": ref.watch(imageProvider),
          });

      FirebaseAuth.instance.currentUser!.updateDisplayName(
        _usernameController.text,
      );
      Navigator.pushReplacementNamed(context, '/homepage');
    } catch (e) {
      print(e);
    }
  }

  void image() async {
    await pickImage((imageBytes) {
      if (imageBytes != null) {
        ref.read(imageProvider.notifier).state = base64Encode(imageBytes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageBase64 = ref.watch(imageProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell us About yourself',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Who do you shop for ?',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children:
                          ['Men', 'Women'].map((gender) {
                            bool isSelected = selectedGender == gender;
                            return Expanded(
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        setState(() => selectedGender = gender),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: gender == 'Men' ? 12.w : 0,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? const Color(0xFF9B6AF7)
                                            : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Create a Username',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: GrayTextField(
                        prefixIcon: Icons.person_outline,
                        controller: _usernameController,
                        hintText: 'Username',
                      ),
                    ),
                    20.customH,
                    Text(
                      'Upload a Profile Picture',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: GestureDetector(
                        onTap: image,
                        child: CircleAvatar(
                          radius: 80.r,
                          foregroundImage:
                              imageBase64.isNotEmpty
                                  ? MemoryImage(base64Decode(imageBase64))
                                  : null,
                          child:
                              imageBase64.isEmpty
                                  ? Icon(
                                    Icons.photo_camera_outlined,
                                    size: 30.r,
                                    color: Colors.grey,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: CustomConfirmButton(
                    title: 'Finish',
                    color: mainColor,
                    onTap: setupUser,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
