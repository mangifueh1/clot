import 'package:clot/auth/create_account_screen.dart';
import 'package:clot/auth/sign_in_screen.dart';
import 'package:clot/presentation/pages/about_you.dart';
import 'package:clot/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/signInScreen' : (context) => SignInScreen(),
  '/createAccountScreen' : (context) => CreateAccountScreen(),
  '/homepage' : (context) => Homepage(),
  '/aboutYou' : (context) => AboutYouScreen(),
};
