import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../shared/remote/cash_helper.dart';
import '../../style/icon_broken.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(key: 'token', value: state.loginModel.id)
                  .then((value) {
                navigateAndFinish(context, const HomeScreen());
              });

              print(state.loginModel.status);
              print(state.loginModel.id);
            } else {
              showToast(text: "error", state: ToastState.ERROR);
              print("error");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/scan_image.jpg'),
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(IconBroken.Profile),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Your username',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        obscureText: LoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(IconBroken.Lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility(context);
                            },
                            icon: Icon(
                              LoginCubit.get(context).suffix,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Enter Your Password ',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppLoginLoadingState,
                        builder: (context) => Container(
                            height: 50,
                            color: Colors.grey[300],
                            child: OutlinedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    context,
                                    username: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Expanded(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    IconBroken.Login,
                                    size: 40,
                                  )
                                ],
                              ),
                            )),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          const SizedBox(
                            width: 0,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: const Text('REGISTER')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                        child: LoginCubit.get(context).errorWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
