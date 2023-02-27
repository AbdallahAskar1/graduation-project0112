import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/modules/login/cubit/state.dart';
import 'package:my_scan_for_solution/style/icon_broken.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/dio_helper.dart';
import '../../../shared/end_points.dart';
// import 'package:untitled1/models/login_model.dart';
// import 'package:untitled1/modules/Login/cubit/state.dart';
// import 'package:untitled1/shared/end_points.dart';
// import 'package:untitled1/shared/network/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  IconData suffix = IconBroken.Password;
  bool isPassword = true;

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility(context) {
    isPassword = !isPassword;
    suffix =
    isPassword ? IconBroken.Hide : IconBroken.Show;
    emit(ShopChangePasswordVisibilityState());
  }

  Widget errorWidget = Container();
  LoginModel? loginModel;


  void userLogin(context,{
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
      showDialog(
          context: context,
          builder: (_) {
            return  AlertDialog(
              title: SingleChildScrollView(

                child: Column(
                  children: const [
                    Text(
                      "Some Thing Wrong\n user not found \n or \n user not found",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // actions: []
            );
          });

      emit(AppLoginErrorState(error.toString()));
    });
  }

  void ErrorWidetChange({required Widget widget}) {
    errorWidget = widget;
    emit(ErrorWidetChangeState());
  }
}
