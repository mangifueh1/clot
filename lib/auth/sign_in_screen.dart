import 'package:clot/core/colors.dart';
import 'package:clot/shared/widgets/bottom_rich_text.dart';
import 'package:clot/shared/widgets/custom_confirm_button.dart';
import 'package:clot/shared/widgets/gray_text_field.dart';
import 'package:clot/core/utils/space_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  SignInScreen({super.key});

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
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
                  "Sign in",
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
                  prefixIcon: Icons.lock_outline,
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                30.customH,
                CustomConfirmButton(
                  title: 'Sign In',
                  color: mainColor,
                  onTap: signIn,
                ),
                20.customH,
                BottomRichText(
                  info: "Don't Have An Account ? ",
                  tappable: "Create One",
                  onTap:
                      () => Navigator.pushReplacementNamed(
                        context,
                        '/createAccountScreen',
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
