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



class RegisterScreen extends StatefulWidget
{

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context)
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            // appBar: AppBar(
            //   leading: IconButton(onPressed: (){
            //     Navigator.pop(context);
            //   },
            //       icon: Icon(
            //           IconBroken.Arrow___Left_2
            //       )),
            // ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow:const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20,
                              offset: Offset(70, 45),
                              spreadRadius: -70,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(left: width*0.4),
                        margin: EdgeInsets.zero,
                        child: Image.asset(
                            'assets/images/colorless_image.png', width: width*0.2,height: height*0.2,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.06),                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
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
                                prefixIcon: Icon(IconBroken.Message),
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
                            ConditionalBuilder(
                              condition: !RegisterCubit.get(context).isRigestaring ,
                              builder: (context) => Container(
                                  height: 50,
                                  color: Colors.grey[300],
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Register',
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Icon(IconBroken.Login,size: 40,)
                                      ],
                                    ),
                                  )
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account?'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Login')),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
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