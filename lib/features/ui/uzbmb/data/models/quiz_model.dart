import 'dart:convert';

class QuizModel {
  final String questionText;
  final int questionId;
  final String varAName;
  final int varAId;
  final String varBName;
  final int varBId;
  final String varCName;
  final int varCId;
  final String varDName;
  final int varDId;
  final int correct;
  int? checked;

  QuizModel({
    required this.questionText,
    required this.questionId,
    required this.varAName,
    required this.varAId,
    required this.varBName,
    required this.varBId,
    required this.varCName,
    required this.varCId,
    required this.varDName,
    required this.varDId,
    required this.correct,
    this.checked,
  });

  factory QuizModel.fromJson(String str) => QuizModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuizModel.fromMap(Map<String, dynamic> json) => QuizModel(
        questionText: json["question_text"],
        questionId: json["question_id"],
        varAName: json["var_a_name"],
        varAId: json["var_a_id"],
        varBName: json["var_b_name"],
        varBId: json["var_b_id"],
        varCName: json["var_c_name"],
        varCId: json["var_c_id"],
        varDName: json["var_d_name"],
        varDId: json["var_d_id"],
        correct: json["correct"],
      );

  Map<String, dynamic> toMap() => {
        "question_text": questionText,
        "question_id": questionId,
        "var_a_name": varAName,
        "var_a_id": varAId,
        "var_b_name": varBName,
        "var_b_id": varBId,
        "var_c_name": varCName,
        "var_c_id": varCId,
        "var_d_name": varDName,
        "var_d_id": varDId,
        "correct": correct,
        "checked": checked,
      };
}
