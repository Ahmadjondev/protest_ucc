import 'package:equatable/equatable.dart';

class StudyModel extends Equatable {
  final String studyName;
  final String studyCode;
  final int sciencePairs;
  final ScienceElement sciences;

  StudyModel({
    required this.studyName,
    required this.studyCode,
    required this.sciencePairs,
    required this.sciences,
  });

  factory StudyModel.fromMap(Map<String, dynamic> json) {
    return StudyModel(
      studyName: json["study_name"],
      studyCode: json["study_code"],
      sciencePairs: json["science_pairs"],
      sciences: ScienceElement.fromMap(json["sciences"]),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [studyName, studyCode, sciences, sciencePairs];
}

class ScienceElement extends Equatable {
  final String science1;
  final String science2;

  ScienceElement({
    required this.science1,
    required this.science2,
  });

  factory ScienceElement.fromMap(Map<String, dynamic> json) {
    print(json);
    return ScienceElement(
      science1: json["science1"],
      science2: json["science2"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [science2, science1];
}
