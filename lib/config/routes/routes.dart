import 'package:clot/features/app/presentation/pages/category/category_list_view.dart';
import 'package:clot/features/app/presentation/pages/category/category_view.dart';
import 'package:clot/features/auth/create_account_screen.dart';
import 'package:clot/features/auth/sign_in_screen.dart';
import 'package:clot/features/app/presentation/pages/about_you.dart';
import 'package:clot/features/app/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/signInScreen' : (context) => SignInScreen(),
  '/createAccountScreen' : (context) => CreateAccountScreen(),
  '/homepage' : (context) => Homepage(),
  '/categoryListView' : (context) => CategoryListView(),
  // '/categoryView' : (context) => CategoryView(),
  '/aboutYou' : (context) => AboutYouScreen(),
};
