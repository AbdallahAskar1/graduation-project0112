import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled1/components/constance.dart';
// import 'package:untitled1/models/login_model.dart';
// import 'package:untitled1/modules/Login/cubit/cubit.dart';
// import 'package:untitled1/shared/end_points.dart';
// import 'package:untitled1/shared/network/dio_helper.dart';

import '../../../components/components.dart';
import '../../../components/constants.dart';
import '../../../models/login_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/network/dio_helper.dart';
import '../../../style/icon_broken.dart';
import '../../home/home_screen.dart';
import '../../login/cubit/cubit.dart';
import 'state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = IconBroken.Show;
  bool isPassword = true;

  bool isRigestaring=false;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Show : IconBroken.Hide ;

    emit(RegisterChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void register(context,{
    required String name,
    required String email,
    required String password,
  }){
    isRigestaring=true;
    emit(RegisterLoadingState());

    DioHelper.postData(

        url: REGISTER,
        data: {
          'username' : name,
          'email' : email,
          'password' : password,
        },
        token: token).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);

      Timer(const Duration(milliseconds: 150),(){
        isRigestaring=false;
        navigateAndFinish(context, const HomeScreen());
        emit(TimerState());
      });
      LoginCubit.get(context).userLogin(context,password:password ,username: email);

      emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      showDialog(
          context: context,
          builder: (_) {
            return  AlertDialog(
                title: SingleChildScrollView(

                  child: Column(
                    children: const [
                      Text(
                        "Failed! Username or Email is already in use!",
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
                actions: []);
          });
      isRigestaring = false;
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }
}