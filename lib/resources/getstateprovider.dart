import 'package:studentz_link/Models/getstate.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class StatelistApiProvider {
  Future<StateModel> getstatelist(country_code) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.State_url + country_code,
      ));
      return StateModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
