import 'dart:io';

import 'package:flutter/material.dart';

abstract class AppStates{}
class AppInitialState extends  AppStates{}
class AppLoadingState extends  AppStates{}
class AppSuccessState extends  AppStates{}
class AppErrorState extends  AppStates{}
class AppSuccessChangeRateState extends  AppStates{}
class SocialTakePhotoSuccessStates extends  AppStates{}
class SocialTakePhotoErrorStates extends  AppStates{}

class TextEditState extends AppStates{
  TextEditingController? nameContraller;
}

class CrppedImageState extends AppStates{
  //File? croppedImage ;

  CrppedImageState(File? imageFile);
}
class LoadingQuestionStates extends AppStates{}

class SuccessQuestionStates extends AppStates{}

class ErrorQuestionStates extends AppStates{}


class LoadingAnswerStates extends AppStates{}

class SuccessAnswerStates extends AppStates{}

class ErrorAnswerStates extends AppStates{}
