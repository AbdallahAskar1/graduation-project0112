import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../style/icon_broken.dart';
// import 'package:untitled1/components/components.dart';
// import 'package:untitled1/style/icon_broken.dart';

class ChangePassword extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
              IconBroken.Arrow___Left_2
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Change Your Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                defaultFormField(
                    controller: currentPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: (String value){
                      return value.length < 6 ? 'Must be at least 8 character' : null;
                    }, prefix: Icons.lock,
                    text: 'Current Password'),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: newPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: (String value){
                      return value.length < 8 ? 'Must be at least 8 character' : null;
                    }, prefix: Icons.lock,
                    text: 'New Password'),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: (String value){
                      return value.length < 8 ? 'Must be at least 8 character' : null;
                    }, prefix: Icons.lock,
                    text: 'Confirm Password'),
                SizedBox(
                  height: 30,
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                  ),
                  child: MaterialButton(
                    child: Text(
                      'Change Password', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                    ),
                    onPressed: (){
                      if(formKey.currentState!.validate()){

                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
