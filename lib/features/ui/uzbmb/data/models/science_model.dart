import 'package:protest/features/ui/uzbmb/data/models/quiz_model.dart';

class ScienceModel {
  final String science;
  final List<QuizModel> questions;

  ScienceModel({
    required this.science,
    required this.questions,
  });

  factory ScienceModel.fromMap(Map<String, dynamic> json) {
    print(json);
    return ScienceModel(
      science: json["science"],
      questions: List.from(json["questions"])
          .map(
            (x) => QuizModel.fromMap(x),
          )
          .toList(),
    );
  }
}
