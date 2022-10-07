import 'package:studentz_link/Models/dashboard.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class DashboarddataApiProvider {
  Future<DashBoardModel> getdashboarddata() async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.dashboard_url,
      ));

      return DashBoardModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
