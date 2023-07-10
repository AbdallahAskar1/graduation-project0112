import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_scan_for_solution/components/components.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../style/icon_broken.dart';
import '../rate/rate_screen.dart';

class AnswerRate extends StatefulWidget {
  final String text;
  final List choiceScores;

  const AnswerRate({super.key, required this.text, required this.choiceScores});

  @override
  State<AnswerRate> createState() => _AnswerRateState();
}

class _AnswerRateState extends State<AnswerRate> {
  TextEditingController questionContraller = TextEditingController();
  TextEditingController answerContraller = TextEditingController();

// var arr =  List.filled(5, null, growable: false);
  @override
  Widget build(BuildContext context) {
    // textOrganization(widget.text);
    questionContraller.text = '${aanswers[0]} ?';
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
                                const SizedBox(height: 40),
                                //*Answers Text* */
                                aanswers.length >= 2
                                    ? buildChoicesRating(
                                        choise: '${aanswers[1]}',
                                        rank: "10%",
                                        present: 0.1,
                                        cubit: cubit)
                                    : Container(),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                                aanswers.length >= 3
                                    ? buildChoicesRating(
                                        choise: '${aanswers[2]}',
                                        rank: "10%",
                                        present: 0.1,
                                        cubit: cubit)
                                    : Container(),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                                aanswers.length >= 4
                                    ? buildChoicesRating(
                                        choise: '${aanswers[3]}',
                                        rank: "10%",
                                        present: 0.1,
                                        cubit: cubit)
                                    : Container(),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                                aanswers.length >= 5
                                    ? buildChoicesRating(
                                        choise: '${aanswers[4]}',
                                        rank: "10%",
                                        present: 0.1,
                                        cubit: cubit)
                                    : Container(),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
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
                                            builder: (context) =>
                                                buildRatingAlertDialog(
                                                    cubit, context));
                                        // cubit.question(
                                        //     text: questionContraller.text,
                                        //     choice: [
                                        //       aanswers[1],
                                        //       aanswers[2],
                                        //       aanswers[3],
                                        //       aanswers[4],
                                        //     ]);
                                      },
                                      child: const Text(
                                        'Please Rate Our App',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                // Text(
                                //     'answer ${cubit.aModel?.question.answer.answer ?? ''}'),
                                TextButton(
                                  onPressed: () {
                                    cubit.answer(
                                        id: cubit.qModel?.id ??
                                            'mmmmmmmmmmmmmmmmmllllll');
                                    print(cubit.aModel?.question.answer.answer);
                                  },
                                  child: const Text(
                                    'Show answer',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ])))));
        });
  }

  SizedBox buildChoicesRating(
      {required String choise,
      required String rank,
      required double present,
      required cubit}) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(choise),
          ),
          cubit.aModel?.question.scores[3] == .000003 ||
                  cubit.aModel?.question.scores[0] == 0.9
              ? CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 100,
                  center: const Text("100%"),
                  progressColor: Colors.green,
                  animation: true,
                  animationDuration: 1500,
                )
              : CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.10,
                  center: const Text("10%"),
                  progressColor: Colors.green,
                  animation: true,
                  animationDuration: 1500,
                )
        ],
      ),
    );
  }

  AlertDialog buildRatingAlertDialog(AppCubit cubit, BuildContext context) {
    return AlertDialog(
        title: const Text(
          'Rate This App',
        ),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please leave face rating. ',
                style: TextStyle(color: Colors.grey[400], height: 1),
              ),
              const SizedBox(
                height: 30,
              ),
              buildRatingBar(cubit)
            ]),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'ok',
                style: TextStyle(fontSize: 20),
              ))
        ]);
  }

  RatingBar buildRatingBar(AppCubit cubit) {
    return RatingBar.builder(
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
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const Icon(Icons.sentiment_dissatisfied_rounded,
                  color: Colors.red);
            case 1:
              return const Icon(Icons.sentiment_dissatisfied,
                  color: Colors.redAccent);
            case 2:
              return const Icon(Icons.sentiment_neutral_rounded,
                  color: Colors.amber);
            case 3:
              return const Icon(Icons.sentiment_satisfied_rounded,
                  color: Colors.lightGreen);
            case 4:
              return const Icon(Icons.sentiment_very_satisfied_rounded,
                  color: Colors.green);
            default:
              return Container();
          }
        });
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:my_scan_for_solution/components/components.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import '../../cubit/cubit.dart';
// import '../../cubit/state.dart';
// import '../../style/icon_broken.dart';
//
// class AnswerRate extends StatefulWidget {
//   final String text;
//
//   const AnswerRate({super.key, required this.text});
//
//   @override
//   State<AnswerRate> createState() => _AnswerRateState();
// }
//
// class _AnswerRateState extends State<AnswerRate> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var cubit = AppCubit.get(context);
//           return Scaffold(
//               appBar: AppBar(
//                 //elevation: 1,
//                 leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(IconBroken.Arrow___Left_2),
//                 ),
//               ),
//               body: buildAnswerBody(context, cubit));
//         });
//   }
//
//   Padding buildAnswerBody(BuildContext context, AppCubit cubit) {
//     return Padding(
//         padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
//         child: Container(
//             padding: const EdgeInsets.all(15.0),
//             child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       //*Question Text* */
//                       Text(
//                         '${aanswers[0]} ?',
//                         style: TextStyle(
//                             fontSize: 20.0, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 40),
//                       //*Answers Text* */
//                       //next  عاوزين نعرف علي الاقل اجابتين او مش ينتقل للصفحة التانية ويدي رسالة الايررور
//                       aanswers.length >= 2
//                           ? buildChoicesRating(
//                               choise: '${aanswers[1]}',
//                               rank: "10%",
//                               present: 0.1,
//                               progressColor: Colors.red)
//                           : Container(),r
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                       aanswers.length >= 3
//                           ? buildChoicesRating(
//                               choise: '${aanswers[2]}',
//                               rank: "30%",
//                               present: 0.3,
//                               progressColor: Colors.orange)
//                           : Container(),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                       aanswers.length >= 4
//                           ? buildChoicesRating(
//                               choise: '${aanswers[3]}',
//                               rank: "60%",
//                               present: 0.6,
//                               progressColor: Colors.yellow)
//                           : Container(),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                       aanswers.length >= 5
//                           ? buildChoicesRating(
//                               choise: '${aanswers[4]}',
//                               rank: "90%",
//                               present: 0.9,
//                               progressColor: Colors.green)
//                           : Container(),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                       ),
//                       const SizedBox(height: 20),
//                       //*Rating button* */
//                       buildRatingDialog(context, cubit)
//                     ]))));
//   }
//
//   SizedBox buildChoicesRating(
//       {required String choise,
//       required String rank,
//       required MaterialColor progressColor,
//       required double present}) {
//     return SizedBox(
//       height: 100,
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Text(choise),
//           ),
//           CircularPercentIndicator(
//             radius: 45.0,
//             lineWidth: 4.0,
//             percent: present,
//             center: Text(rank),
//             // taked from api
//             progressColor: progressColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container buildRatingDialog(BuildContext context, AppCubit cubit) {
//     return Container(
//         width: double.infinity,
//         height: 60,
//         decoration: const BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//         ),
//         child: MaterialButton(
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) => buildRatingAlertDialog(cubit, context));
//             },
//             child: const Text('Please Rate Our App',
//                 style: TextStyle(color: Colors.white, fontSize: 20))));
//   }
//
//   AlertDialog buildRatingAlertDialog(AppCubit cubit, BuildContext context) {
//     return AlertDialog(
//         title: const Text(
//           'Rate This App',
//         ),
//         content: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Please leave face rating. ',
//                 style: TextStyle(color: Colors.grey[400], height: 1),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               buildRatingBar(cubit)
//             ]),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'ok',
//                 style: TextStyle(fontSize: 20),
//               ))
//         ]);
//   }
//
//   RatingBar buildRatingBar(AppCubit cubit) {
//     return RatingBar.builder(
//         onRatingUpdate: (rating) {
//           cubit.rating = rating;
//         },
//         updateOnDrag: true,
//         initialRating: cubit.rating,
//         minRating: 1,
//         direction: Axis.horizontal,
//         allowHalfRating: true,
//         itemCount: 5,
//         itemSize: 30,
//         itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//         itemBuilder: (context, index) {
//           switch (index) {
//             case 0:
//               return const Icon(Icons.sentiment_dissatisfied_rounded,
//                   color: Colors.red);
//             case 1:
//               return const Icon(Icons.sentiment_dissatisfied,
//                   color: Colors.redAccent);
//             case 2:
//               return const Icon(Icons.sentiment_neutral_rounded,
//                   color: Colors.amber);
//             case 3:
//               return const Icon(Icons.sentiment_satisfied_rounded,
//                   color: Colors.lightGreen);
//             case 4:
//               return const Icon(Icons.sentiment_very_satisfied_rounded,
//                   color: Colors.green);
//             default:
//               return Container();
//           }
//         });
//   }
// }

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
