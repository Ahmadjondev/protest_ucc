import 'package:dio/dio.dart';
import 'package:protest/common/apis.dart';
import 'package:protest/features/ui/uzbmb/data/models/major_model.dart';
import 'package:protest/features/ui/uzbmb/data/models/science_model.dart';

class MajorService {
  Future<List<StudyModel>> getMajors() async {
    var dio = Dio();
    var res = await dio.get(Apis.studies);
    var list = List.from(res.data).map((e) => StudyModel.fromMap(e)).toList();
    return list;
  }

  Future<List<ScienceModel>> getQuizzes(int id) async {
    var dio = Dio();
    var res = await dio.get("${Apis.questions}$id/");
    var list = List.from(res.data).map((e) => ScienceModel.fromMap(e)).toList();
    return list;
  }
}
