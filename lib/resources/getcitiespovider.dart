import 'package:studentz_link/Models/getcities.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class CitieslistApiProvider {
  Future<CityModel> getcitylist(state_code) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.District_url + state_code,
      ));
      return CityModel.fromJson(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
