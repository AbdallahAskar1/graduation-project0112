import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../modules/answer/answer.dart';
import '../style/icon_broken.dart';

class ScanText extends StatefulWidget {
  final String text;

  const ScanText({super.key, required this.text});

  @override
  State<ScanText> createState() => _ScanTextState();
}

class _ScanTextState extends State<ScanText> {
  TextEditingController scannedContraller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    scannedContraller.text = widget.text;
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
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
                    title: Text('Edit Question'),
                    centerTitle: true,
                  ),
                  body: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Q: ',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          controller: scannedContraller,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (value) {
                                            //store text after change to transmitted to answer page
                                            'text is : $value';
                                            scannedContraller.text = value;
                                          })
                                    ]),
                                const SizedBox(height: 20),
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
                                          textOrganization(
                                              scannedContraller.text);
                                          print(aanswers);
                                          navigateTo(
                                              context,
                                              AnswerRate(
                                                text: scannedContraller.text,
                                                choiceScores: [
                                                  cubit.aModel?.question
                                                      .scores[0],
                                                  cubit.aModel?.question
                                                      .scores[1],
                                                  cubit.aModel?.question
                                                      .scores[2],
                                                  cubit.aModel?.question
                                                      .scores[3],
                                                ],
                                              ));
                                          cubit.question(
                                              text: aanswers[0],
                                              choice: [
                                                aanswers[1],
                                                aanswers[2],
                                                aanswers[3],
                                                aanswers[4],
                                              ]);
                                          // cubit.question(
                                          //     text: scannedContraller.text);
                                          // scannedContraller.text;
                                        },
                                        child: const Text(
                                          'Show The Answer',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )))
                              ]))));
            }));
  }
}
//here we will take text to regular expression
//'The question should contain two or more choices'
