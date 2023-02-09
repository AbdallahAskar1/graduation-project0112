// import 'dart:io';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:untitled1/cubit/states.dart';
// import 'package:untitled1/shared/end_points.dart';
// import 'package:untitled1/shared/network/dio_helper.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_scan_for_solution/cubit/state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  double rating = 0;

  void changeRate() {
    emit(AppSuccessChangeRateState());
  }




// bool textScanning = false;
//
// XFile? imageFile;
//
// String scannedText = "";

// void getImage(ImageSource source) async {
//   try {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     if (pickedImage != null) {
//       textScanning = true;
//      File? imageFile = File(pickedImage.path);
//       getRecognisedText(pickedImage);
//       emit(SocialTakePhotoSuccessStates());
//     }
//   } catch (e) {
//     textScanning = false;
//     imageFile = null;
//     scannedText = "Error occured while scanning";
//     emit(SocialTakePhotoErrorStates());
//   }
// }
//
// void getRecognisedText(XFile image) async {
//   final inputImage = InputImage.fromFilePath(image.path);
//   final textDetector = GoogleMlKit.vision.textRecognizer();
//   RecognizedText recognisedText = await textDetector.processImage(inputImage);
//   await textDetector.close();
//   scannedText = "";
//   for (TextBlock block in recognisedText.blocks) {
//     for (TextLine line in block.lines) {
//       scannedText = scannedText + line.text + "\n";
//     }
//   }
//   textScanning = false;
// }
}
