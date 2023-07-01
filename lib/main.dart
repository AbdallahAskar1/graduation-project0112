

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/shared/network/dio_helper.dart';
import 'package:my_scan_for_solution/shared/remote/cash_helper.dart';
import 'cubit/cubit.dart';
import 'modules/splash/splash.dart';
import 'observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   Widget widget =SplashPage();
 /* token = CacheHelper.getData(key: 'token');
  print(token);
 
  if(SplashPage != null)
  {
    if(token != null) widget = HomeScreen();
    else widget = LoginScreen();
  } else
  {
    widget = SplashPage();
  }*/
  runApp( MyApp(startWidget: widget,));
}
class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    required this.startWidget
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:const AppBarTheme(
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                backgroundColor: Colors.white,
                titleTextStyle:  TextStyle(
                    color: Colors.black,
                    fontFamily: 'Jannah',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                elevation: 0
            ),
            fontFamily: 'Jannah'
        ),
        home:  startWidget,
      ),
    );
  }
}
