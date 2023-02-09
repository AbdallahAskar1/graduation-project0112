import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../style/icon_broken.dart';
// import 'package:untitled1/cubit/cubit.dart';
// import 'package:untitled1/cubit/states.dart';
// import 'package:untitled1/style/icon_broken.dart';
// import 'package:untitled1/text/scan_text.dart';

class AnswerRate extends StatefulWidget {
  final String question ;
  AnswerRate({required this.question});

  @override
  State<AnswerRate> createState() => _AnswerRateState();
}

class _AnswerRateState extends State<AnswerRate> {

  TextEditingController questionContraller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    questionContraller.text = widget.question;

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
                icon: Icon(
                    IconBroken.Arrow___Left_2
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Expanded(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: TextField(
                            readOnly: true,
                            controller: questionContraller,
                            maxLines: null,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    'Answer One'
                                ),
                              ),
                              new CircularPercentIndicator(
                                radius: 45.0,
                                lineWidth: 4.0,
                                percent: 0.10,
                                center: new Text("10%"),  // taked from api
                                progressColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    'Answer Two'
                                ),
                              ),
                              new CircularPercentIndicator(
                                radius: 45.0,
                                lineWidth: 4.0,
                                percent: 0.30,
                                center: new Text("30%"),
                                progressColor: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    'Answer Three'
                                ),
                              ),
                              new CircularPercentIndicator(
                                radius: 45.0,
                                lineWidth: 4.0,
                                percent: 0.60,
                                center: new Text("60%"),
                                progressColor: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    'Answer Four'
                                ),
                              ),
                              new CircularPercentIndicator(
                                radius: 45.0,
                                lineWidth: 4.0,
                                percent: 0.90,
                                center: new Text("90%"),
                                progressColor: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        title: Text(
                                          'Rate This App',


                                        ),
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Please leave face rating. ',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  height: 1
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ), RatingBar.builder(
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
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, index) {
                                                switch (index) {
                                                  case 0:
                                                    return Icon(
                                                      Icons
                                                          .sentiment_very_dissatisfied,
                                                      color: Colors.red,
                                                    );
                                                  case 1:
                                                    return Icon(
                                                      Icons.sentiment_dissatisfied,
                                                      color: Colors.redAccent,
                                                    );
                                                  case 2:
                                                    return Icon(
                                                      Icons.sentiment_neutral,
                                                      color: Colors.amber,
                                                    );
                                                  case 3:
                                                    return Icon(
                                                      Icons.sentiment_satisfied,
                                                      color: Colors.lightGreen,
                                                    );
                                                  case 4:
                                                    return Icon(
                                                      Icons
                                                          .sentiment_very_satisfied,
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
                                              child: Text(
                                                'ok',
                                                style: TextStyle(
                                                    fontSize: 20
                                                ),
                                              ))
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                'Please Rate Our App', style: TextStyle(
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
              ),
            ),

          );
        });

  }
}
