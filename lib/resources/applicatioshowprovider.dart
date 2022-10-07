import 'package:studentz_link/Models/applicationshowmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class ApplicationShowApiProvider {
  Future<ApplicationShowModel> getapplicationshow(
      {required String applicationid}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.applicationshowurl + applicationid,
      ));
      return ApplicationShowModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
