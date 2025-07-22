import 'package:clot/core/colors.dart';
import 'package:clot/shared/widgets/bottom_rich_text.dart';
import 'package:clot/shared/widgets/custom_confirm_button.dart';
import 'package:clot/shared/widgets/gray_text_field.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  Future<void> createUser() async {
    var ref = FirebaseAuth.instance;

    try {
      await ref.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/aboutYou');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                40.customH,
                GrayTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline,
                ),
                30.customH,
                GrayTextField(
                  prefixIcon: Icons.person_outline,
                  controller: _usernameController,
                  hintText: 'Username',
                ),
                30.customH,
                GrayTextField(
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                30.customH,
                CustomConfirmButton(
                  title: 'Submit',
                  color: mainColor,
                  onTap: createUser,
                ),
                20.customH,
                BottomRichText(
                  info: "Already Got an Account ? ",
                  tappable: "Sign In",
                  onTap:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/signInScreen',
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
