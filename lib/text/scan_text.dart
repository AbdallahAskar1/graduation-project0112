import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../modules/answer/answer.dart';
import '../style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

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
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Q: ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
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
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),                        
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
                                  cubit.question(text: scannedContraller.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnswerRate(
                                          text: scannedContraller.text,
                                        ),
                                      ));
                                  scannedContraller.text;
                                },
                                child: const Text(
                                  'Show The Answer',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
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
//here we will take text to regular expression