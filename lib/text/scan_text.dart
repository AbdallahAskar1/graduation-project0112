import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../modules/answer/answer.dart';
import '../style/icon_broken.dart';
// import 'package:untitled1/cubit/cubit.dart';
// import 'package:untitled1/cubit/states.dart';
// import 'package:untitled1/modules/asnswer/answer.dart';
// import 'package:untitled1/modules/rate/rate_screen.dart';
// import 'package:untitled1/style/icon_broken.dart';

class ScanText extends StatefulWidget {
  final String text;
  ScanText({
    required this.text
  });

  @override
  State<ScanText> createState() => _ScanTextState();
}

class _ScanTextState extends State<ScanText> {

  TextEditingController scannedContraller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    scannedContraller.text = widget.text ;

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
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
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child:   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q: ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            controller: scannedContraller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              //store text after change to transmitted to answer page
                              print('text is : ${value}');
                              scannedContraller.text = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AnswerRate(question: scannedContraller.text,),));

                          },
                          child: Text(
                            'Show The Answer',style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
