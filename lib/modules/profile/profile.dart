import 'package:flutter/material.dart';

import '../../style/icon_broken.dart';

class ProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Account' ,style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Your Name';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Your Email';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone',
                        border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Your Phone';
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Update Profile', style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
                      ),
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                        }
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 17,
                  // ),
                  // Container(
                  //        width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue,
                  //     borderRadius: BorderRadius.only(
                  //       topRight: Radius.circular(12),
                  //       bottomLeft: Radius.circular(12),
                  //     )
                  // ),
                  //        child: MaterialButton(
                  //          child: Text(
                  //            'Log Out', style: TextStyle(
                  //            color: Colors.white,
                  //            fontSize: 15
                  //          ),
                  //          ),
                  //          onPressed: (){
                  //
                  //            }
                  //      ),
                  // ),
                ],
              ),
            ),
          ),
        )


    );
  }
}
