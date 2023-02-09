import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../animation/fade_animation.dart';
import '../../components/components.dart';
import '../../components/constants.dart';
import '../../shared/remote/cash_helper.dart';
import '../../style/icon_broken.dart';
import '../home/home_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
// import 'package:untitled1/animation/fade_animation.dart';
// import 'package:untitled1/components/components.dart';
// import 'package:untitled1/components/constance.dart';
// import 'package:untitled1/modules/home/home_screen.dart';
// import 'package:untitled1/shared/remote/cache_helper.dart';
// import 'package:untitled1/style/icon_broken.dart';
// import 'cubit/cubit.dart';
// import 'cubit/state.dart';


class RegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(key: 'token', value: state.loginModel.id).then((value) {
                token = state.loginModel.id!;
                navigateAndFinish(context, HomeScreen());
              });

            }

          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },
                  icon: Icon(
                      IconBroken.Arrow___Left_2
                  )),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                            'assets/images/scan_image.jpg'
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'REGISTER NOW',style: TextStyle(
                            fontSize: 25
                        ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('User Name'),
                            prefixIcon: Icon(IconBroken.User),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Enter Your Email',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter your password';
                            }
                            return null;
                          },

                          obscureText: RegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(IconBroken.Lock),
                            suffixIcon: IconButton(
                              onPressed: (){
                                RegisterCubit.get(context).changePasswordVisibility();
                              },
                              icon: Icon(
                                RegisterCubit.get(context).suffix,
                              ),
                            ),
                            labelText: 'Enter Your Password',
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        FadeAnimation(1.1,
                          child: ConditionalBuilder(
                            condition: !RegisterCubit.get(context).isRigestaring ,
                            builder: (context) => Container(
                                height: 50,
                                color: Colors.grey[300],
                                child: FadeAnimation(1.1,
                                  child: OutlinedButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        RegisterCubit.get(context).register(context,
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: FadeAnimation(1.1,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const [
                                          FadeAnimation(1.1,
                                            child: Expanded(
                                              child: Text(
                                                'REGISTER',
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(IconBroken.Login,size: 40,)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}