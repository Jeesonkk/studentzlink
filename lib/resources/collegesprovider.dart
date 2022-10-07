import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class CollegelistApiProvider {
  Future<CollegeModel> getcollegelist(searchText) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.college_url,
          queryParameters: {'search': searchText}));
      return CollegeModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
