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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20,
                                offset: Offset(70, 45),
                                spreadRadius: -70,
                              )
                            ]),
                        padding: EdgeInsets.only(left: width * 0.4),
                        margin: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/images/colorless_image.png',
                          width: width * 0.2,
                          height: height * 0.2,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.15),
                      child: Column(
                        children: [
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
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Login',
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
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
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
                                          builder: (context) =>
                                              RegisterScreen()),
                                    );
                                  },
                                  child: const Text('Register')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
