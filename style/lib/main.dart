import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:style/provider/login_provider.dart';
import 'package:style/provider/register_provider.dart';
import 'package:style/view/home_view.dart';
import 'package:style/view/welcome_view.dart';
import 'package:style/widget/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => (LoginProvider()),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => (RegisterProvider()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NavBar();
            } else {
              return WelcomeView();
            }
          },
        ),
      ),
    );
  }
}
