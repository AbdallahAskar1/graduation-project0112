import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/components/components.dart';
import 'package:my_scan_for_solution/modules/login/cubit/state.dart';
import 'package:my_scan_for_solution/style/icon_broken.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/dio_helper.dart';
import '../../../shared/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility(context) {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

  Widget errorWidget = Container();
  LoginModel? loginModel;

  void userLogin(
    context, {
    required String username,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {'username': username, 'password': password}).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print("succ");
      emit(AppLoginSuccessState(loginModel!));
    }).catchError((error) {
      print("####################################${error.toString()}");
      showErrorDialog(
          context: context,
          text: "Some Thing Wrong\n user not found \n or \n wrong password");

      emit(AppLoginErrorState(error.toString()));
    });
  }

  void ErrorWidetChange({required Widget widget}) {
    errorWidget = widget;
    emit(ErrorWidetChangeState());
  }
}
//
