import 'package:clot/core/colors.dart';
import 'package:clot/shared/widgets/custom_confirm_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/widgets/gray_text_field.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  String selectedGender = 'Men';
  final TextEditingController _usernameController = TextEditingController();

  final List<String> ageRanges = ['Under 18', '18-24', '25-34', '35-44', '45+'];

  Future<void> setupUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('usernames')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            "username": _usernameController.text,
            "gender": selectedGender,
          });

      // Navigator.pushReplacementNamed(context, '/homepage');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: CustomConfirmButton(
          title: 'Finish',
          color: mainColor,
          onTap: setupUser,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
                          onTap: () => setState(() => selectedGender = gender),
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
                                color: isSelected ? Colors.white : Colors.black,
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
            ],
          ),
        ),
      ),
    );
  }
}
