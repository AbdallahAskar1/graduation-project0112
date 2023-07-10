class AnswerModel {
  AnswerModel({
    required this.question,
  });

  late final Question question;

  AnswerModel.fromJson(Map<String, dynamic> json) {
    question = Question.fromJson(json['question']);
  }
}

class Question {
  Question({
    required this.id,
    required this.questionBody,
    required this.choices,
    required this.answer,
    required this.searchResults,
    required this.V,
    required this.scores,
  });

  late final String id;
  late final String questionBody;
  late final List<String> choices;
  late final Answer answer;
  late final List<dynamic> searchResults;
  late final int V;
  late final List<int> scores;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    questionBody = json['question_body'];
    choices = List.castFrom<dynamic, String>(json['choices']);
    answer = Answer.fromJson(json['answer']);
    searchResults = List.castFrom<dynamic, dynamic>(json['search_results']);
    V = json['__v'];
    scores = List.castFrom<dynamic, int>(json['scores']);
  }
}

class Answer {
  Answer({
    required this.score,
    required this.start,
    required this.end,
    required this.answer,
    required this.id,
  });

  late final double score;
  late final int start;
  late final int end;
  late final String answer;
  late final String id;

  Answer.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    start = json['start'];
    end = json['end'];
    answer = json['answer'];
    id = json['_id'];
  }
}
