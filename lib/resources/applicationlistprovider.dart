import 'package:studentz_link/Models/applicationlistmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class ApplicationlistApiProvider {
  Future<ApplicationListModel> getapplicationlist(
      {searchText, collegeid, courseid, batchid, status}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.applicationlist,
          queryParameters: {
            'search': searchText,
            'college_id': collegeid,
            'course_id': courseid,
            'batch_id': batchid,
            'status': status,
          }));
      return ApplicationListModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
