class RegxText{
   String question;
   List<String> answers;
   final String statement;
  RegxText(this.question, this.answers, this.statement);


  void regularExpression(String stm){

    var question_shape1_regx = RegExp(r'\((\d+)\)(.*)\?');

    var question_shape2_regx = RegExp(r'([\d]{1,2})\-(.*)\?$');

    var answer_shape1_regx = RegExp(r'(\w)\-(.*)\.');

    var answer_shape2_regx = RegExp(r'(\d+)\-(.*)\.');


    // if(question_shape1_regx !=null){
      for(var q1 in question_shape1_regx.allMatches(stm)){
      String  question =  q1.group(0).toString();
      this.question = question;
        // print("${q1.group(0)} \n");
        // print("\n");
      // }
    }
    // if(question_shape2_regx !=null) {
      for(var q2 in question_shape2_regx.allMatches(stm)){
        String  question =  q2.group(0).toString();
        this.question = question;
        // print("${q2.group(0)} \n");

      // }
    }

    // if(answer_shape1_regx !=null){
      for(var a1 in answer_shape1_regx.allMatches(stm)){
       List<String> answers = a1.group(0).toString().split('.');

        // print("${a1.group(0).toString().split('.')} \n");
      // }
    }


    for(var a2 in answer_shape2_regx.allMatches(stm)){
      List<String> answers = a2.group(0).toString().split('.');
      // print("${a2.group(0).toString().split('.')} \n");
    }

  }
}