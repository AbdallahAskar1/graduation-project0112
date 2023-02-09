// import 'package:untitled1/models/login_model.dart';

import 'package:my_scan_for_solution/models/login_model.dart';

abstract class LoginState{}
class LoginInitialState extends LoginState{}
class ShopLoginLoadingState extends LoginState{}
class ShopChangePasswordVisibilityState extends LoginState{}



class AppLoginLoadingState extends  LoginState{}
class AppLoginSuccessState extends  LoginState{
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}
class AppLoginErrorState extends  LoginState{
  final String error;

  AppLoginErrorState(this.error);
}

class ErrorWidetChangeState extends  LoginState{}