import 'package:flutter/material.dart';
import 'package:my_scan_for_solution/animation/fade_animation.dart';
import 'package:my_scan_for_solution/shared/remote/cash_helper.dart';
import 'package:my_scan_for_solution/components/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const colorizeColors = [
      Color.fromARGB(255, 40, 73, 100),
      Color.fromARGB(255, 32, 30, 95),
      Color.fromARGB(255, 17, 33, 68),
      Color.fromARGB(255, 16, 34, 63),
    ];
    TextStyle colorizeTextStyle = TextStyle(
      fontSize: width * 0.08,
      fontWeight: FontWeight.bold,
    );

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
            padding:  EdgeInsets.only( right: width * 0.08),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: SizedBox(
                  height: height * 0.5,  //300
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: height * 0.25,
                          width: width * 0.4,
                          child: Image.asset('assets/images/s.jpg')),
                      SizedBox(
                        child: DefaultTextStyle(
                          style:  TextStyle(
                            fontSize: width * 0.13, //40
                            color: Color.fromARGB(255, 40, 73, 100),
                          ),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              pause: const Duration(seconds: 3),
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'can',
                                  speed: const Duration(seconds: 1),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(14,
            child: SizedBox(
              width: width * 0.5,
              height: height * 0.23,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'For Solution',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
          SizedBox(height: height * 0.1,),


          FadeAnimation(
            16,
            child: Padding(
              padding:  EdgeInsets.only( left: width * 0.05),  //20
              child: SlideAction(
                alignment: Alignment.bottomCenter,
                innerColor: Colors.blue,
                outerColor: Colors.white,
                elevation: 0,
                text: 'Slide To Enter',
                onSubmit: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => widget));
                },
                sliderButtonIcon: Container(
                  width: width * 0.11,
                  height: height * 0.06,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200)),
                  child: Image.asset(
                    'assets/images/colorless_image.png',
                    width: width * 0.25,
                    height: height * 0.06,
                  ),
                ),
                submittedIcon: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
