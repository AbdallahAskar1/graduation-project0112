// import 'package:untitled1/models/login_model.dart';

import '../../../models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}
class TimerState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;
  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}