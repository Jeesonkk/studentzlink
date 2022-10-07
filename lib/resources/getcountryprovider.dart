import 'package:studentz_link/Models/getcountry.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class CountrylistApiProvider {
  Future<CountryModel> getcountrylist() async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.Country_url,
      ));
      return CountryModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
