import 'package:flutter/material.dart';
import 'package:my_scan_for_solution/shared/remote/cash_helper.dart';
import 'package:my_scan_for_solution/components/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_scan_for_solution/style/icon_broken.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
// import 'package:untitled1/modules/Login/Login_Screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /*
   token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget =SplashPage();
  if(SplashPage != null)
  {
    if(token != null) widget = HomeScreen();
    else widget = LoginScreen();
  } else
  {
    widget = SplashPage();
  }
  */
  @override
  Widget build(BuildContext context) {
    token = CacheHelper.getData(key: 'token');
    token;
    Widget widget;
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = LoginScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, right: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: SizedBox(
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/images/s.jpg')),
                      SizedBox(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 40, 73, 100),
                          ),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              pause: const Duration(seconds: 3),
                              animatedTexts: [
                                TypewriterAnimatedText('can',
                                    speed: const Duration(seconds: 1)),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 20),
            child: SlideAction(
              alignment: Alignment.bottomCenter,
              innerColor: Colors.white,
              outerColor: Colors.blue,
              elevation: 0,
              text: 'Slide To Enter',
              onSubmit: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => widget));
              },
              sliderButtonIcon: Container(
                width: 30,
                height: 30,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(200)),
                child: Image.asset(
                  'assets/images/s.jpg',
                  width: 20,
                  height: 20,
                ),
              ),
              submittedIcon:const Icon(IconBroken.Unlock),
            ),
          ),
        ],
      ),
    );
  }
}
