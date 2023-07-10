import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/cubit/state.dart';

import '../components/constants.dart';
import '../models/question_model.dart';
import '../modules/answer/answer_model.dart';
import '../shared/end_points.dart';
import '../shared/network/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  double rating = 0;

  void changeRate() {
    emit(AppSuccessChangeRateState());
  }

  QModel? qModel;

  void question({ required String text,
    required List<String> choice,}) {
    emit(LoadingQuestionStates());
    DioHelper.postData(
        url: QUESTION, data: {
      'question_body': text, 'choices': choice,
    }, token: token).then((value) {
      qModel = QModel.fromJson(value.data);
      print(token);
      print(
          'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
      emit(SuccessQuestionStates());
    }).catchError((error) {
      emit(ErrorQuestionStates());
      print(error.toString());
    });
  }

  AnswerModel? aModel;

  void answer({
    required String id,}) {
    emit(LoadingAnswerStates());
    DioHelper.getData(
        url: ANSWER(id: id), token: token).then((value) {
      aModel = AnswerModel.fromJson(value.data);
      print(
          'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
      emit(SuccessAnswerStates());
    }).catchError((error) {
      emit(ErrorAnswerStates());
      print(error.toString());
    });
  }}
// bool textScanning = false;//
// XFile? imageFile;//
// String scannedText = "";
// void getImage(ImageSource source) async {//   try {
//     final pickedImage = await ImagePicker().pickImage(source: source);//     if (pickedImage != null) {
//       textScanning = true;//      File? imageFile = File(pickedImage.path);
//       getRecognisedText(pickedImage);//       emit(SocialTakePhotoSuccessStates());
//     }//   } catch (e) {
//     textScanning = false;//     imageFile = null;
//     scannedText = "Error occured while scanning";//     emit(SocialTakePhotoErrorStates());
//   }// }
//// void getRecognisedText(XFile image) async {
//   final inputImage = InputImage.fromFilePath(image.path);
//   final textDetector = GoogleMlKit.vision.textRecognizer();//   RecognizedText recognisedText = await textDetector.processImage(inputImage);
//   await textDetector.close();//   scannedText = "";
//   for (TextBlock block in recognisedText.blocks) {//     for (TextLine line in block.lines) {
//       scannedText = scannedText + line.text + "\n";//     }
//   }//   textScanning = false;
// }}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_scan_for_solution/cubit/state.dart';
//
// import '../components/constants.dart';
// import '../models/question_model.dart';
// import '../shared/end_points.dart';
// import '../shared/network/dio_helper.dart';
//
// class AppCubit extends Cubit<AppStates> {
//   AppCubit() : super(AppInitialState());
//
//   static AppCubit get(context) => BlocProvider.of(context);
//
//   double rating = 0;
//
//   void changeRate() {
//     emit(AppSuccessChangeRateState());
//   }
//   QModel? qModel;
//   void question({
//     required String text,
//   }){
//     emit(LoadingQuestionStates());
//     DioHelper.postData(
//         url: QUESTION,
//         data: {
//           'message' : text,
//         },
//         token: token).then((value) {
//       qModel = QModel.fromJson(value.data);
//       print('dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
//       emit(SuccessQuestionStates());
//     }).catchError((error){
//       emit(ErrorQuestionStates());
//       print(error.toString());
//     });
//   }
// }
