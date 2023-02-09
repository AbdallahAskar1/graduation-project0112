import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';
// import 'package:untitled1/modules/Login/Login_Screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/scan_image.jpg',
        fit: BoxFit.cover,
        height: 180,
        width: 180,),
      title: Text(
        "Scan Text",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.blue,
      loadingText: Text("Loading..."),
      navigator: LoginScreen(),
      durationInSeconds: 5,
    );
  }
}