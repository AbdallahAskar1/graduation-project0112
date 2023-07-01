import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_scan_for_solution/components/components.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../style/icon_broken.dart';

class AnswerRate extends StatefulWidget {
  final String text;
  const AnswerRate({super.key, required this.text});

  @override
  State<AnswerRate> createState() => _AnswerRateState();
}

class _AnswerRateState extends State<AnswerRate> {
  TextEditingController questionContraller = TextEditingController();
  TextEditingController answerContraller = TextEditingController();

  // var arr =  List.filled(5, null, growable: false);

  @override
  Widget build(BuildContext context) {
    textOrganization(widget.text);
    questionContraller.text = Text('${aanswers[0]} ?').toString();
    print(aanswers);
    print(widget.text);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //*Question Text* */
                      TextField(
                        readOnly: true,
                        controller: questionContraller,
                        maxLines: null,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      //*Answers Text* */
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(//first answer
                                  '${aanswers[1]}'),
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.10,
                              center: const Text("10%"), // taked from api
                              progressColor: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(//secound answer
                                  '${aanswers[2]}'),
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.30,
                              center: const Text("30%"),
                              progressColor: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(//third answer
                                  '${aanswers[3]}'),
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.60,
                              center: const Text("60%"),
                              progressColor: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text('${aanswers[4]}'),
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.90,
                              center: const Text("90%"),
                              progressColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //*Rating button* */
                      Container(
                          width: double.infinity,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Rate This App',
                                  ),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Please leave face rating. ',
                                        style: TextStyle(
                                            color: Colors.grey[400], height: 1),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      RatingBar.builder(
                                        onRatingUpdate: (rating) {
                                          cubit.rating = rating;
                                        },
                                        updateOnDrag: true,
                                        initialRating: cubit.rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, index) {
                                          switch (index) {
                                            case 0:
                                              return const Icon(
                                                IconBroken
                                                    .sentimentVeryDissatisfied,
                                                color: Colors.red,
                                              );
                                            case 1:
                                              return const Icon(
                                                IconBroken
                                                    .sentimentDissatisfied,
                                                color: Colors.redAccent,
                                              );
                                            case 2:
                                              return const Icon(
                                                IconBroken.sentimentNeutral,
                                                color: Colors.amber,
                                              );
                                            case 3:
                                              return const Icon(
                                                IconBroken.sentimentSatisfied,
                                                color: Colors.lightGreen,
                                              );
                                            case 4:
                                              return const Icon(
                                                Icons.email,
                                                color: Colors.green,
                                              );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'ok',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                ),
                              );
                            },
                            child: const Text(
                              'Please Rate Our App',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
//here we call the regular expression

/*
*here old regular expression*
  void regularExpression(String stm) {
      var question_shape1_regx = RegExp(r'\((\d+)\)(.*)\?');

      var question_shape2_regx = RegExp(r'([\d]{1,2})\-(.*)\?$');

      var answer_shape1_regx =
          RegExp(r'(\w)\-(.*)\.$', multiLine: true, dotAll: true);

      var answer_shape2_regx =
          RegExp(r'(\d+)\-(.*)\.', multiLine: true, dotAll: true);

      var q1;
      // if(question_shape1_regx !=null){
      for (q1 in question_shape1_regx.allMatches(stm)) {
        String question = q1.group(0).toString();
        print("${q1.group(0)} \n");

        questionContraller.text = question;
        // }
      }
      // if(question_shape2_regx !=null) {
      for (var q2 in question_shape2_regx.allMatches(stm)) {
        String question = q2.group(0).toString();
        questionContraller.text = question;
        print("${q2.group(0)} \n");

        // }
      }

      // if(answer_shape1_regx !=null){

       for(var a1 in answer_shape1_regx.allMatches(stm)){
        acc = a1.group(0).toString().split('.');
          // aanswers.add(a1.group(0).toString());
          print("${a1.group(0).toString()} \n");
        }
        aanswers.add(acc);
      //var a1 = answer_shape1_regx.allMatches(stm).toString().split('.');
     //print( '*********answer1 is $a1*****************************************');
     // print(aanswers);
      for (var a2 in answer_shape2_regx.allMatches(stm)) {
        aanswers = a2.group(0).toString().split('.');

       // print("${a2.group(0).toString().split('.')} \n");
      }
    }
    regularExpression(widget.text);
 */