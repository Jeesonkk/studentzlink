import 'package:studentz_link/Models/teamlist.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class TeamslistApiProvider {
  Future<TeamListModel> getteamlist(rolename) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.team_url,
          queryParameters: {
            'roles[]': rolename,
          }));

      return TeamListModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
