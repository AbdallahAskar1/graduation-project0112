

abstract class QuestionState{}

class QuestionInitialState extends QuestionState{}

class QuetionSucessState extends QuestionState{}

class QuetionErrorState extends QuestionState{
  final String error;
  QuetionErrorState(this.error);
}

