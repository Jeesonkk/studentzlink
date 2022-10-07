import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class CourselistApiProvider {
  Future<CourseModel> getcourselist(college_id, searchText) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.Course_Url,
          queryParameters: {'college_id': college_id, 'search': searchText}));
      return CourseModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
