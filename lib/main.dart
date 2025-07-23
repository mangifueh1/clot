import 'package:clot/features/app/presentation/pages/category/category_list_view.dart';
import 'package:clot/features/auth/create_account_screen.dart';
import 'package:clot/features/auth/sign_in_screen.dart';
import 'package:clot/firebase_options.dart';
import 'package:clot/features/app/presentation/pages/about_you.dart';
import 'package:clot/features/app/presentation/pages/homepage.dart';
import 'package:clot/config/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
          routes: routes,
        );
      },
      // child: CategoryListView(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const Homepage();
          }
          return SignInScreen();
        },
      ),
    );
  }
}
