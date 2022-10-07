import 'package:studentz_link/Models/rolelist.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class RoleslistApiProvider {
  Future<RoleListModel> getrolelist() async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.role_url,
      ));
      return RoleListModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
