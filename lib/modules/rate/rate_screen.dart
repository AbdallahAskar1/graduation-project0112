import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:untitled1/cubit/cubit.dart';
// import 'package:untitled1/cubit/states.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating;
                });

              },
              updateOnDrag: true,
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 46,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
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
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
                return Container();
              },

            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Rating:  $rating',style: TextStyle(
                fontSize: 40
            ),
            ),
            TextButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Rate This App',


                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          ),RatingBar.builder(
                            onRatingUpdate: (rating) {
                              setState(() {
                                this.rating = rating;
                              });

                            },
                            updateOnDrag: true,
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
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
                                    Icons.sentiment_very_satisfied,
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
                            onPressed: (){
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
                  'Show Dialog',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
