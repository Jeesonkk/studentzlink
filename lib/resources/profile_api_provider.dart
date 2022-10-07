import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/profile.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class ProfileApiProvider {
  Future<Response> getUserProfile() async {
    print('profile api calling-------------');
    try {
      Response profile = Response(
          address: '',
          avatar: '',
          bloodType: '',
          city: '',
          country: '',
          createdAt: '',
          createdBy: '',
          email: '',
          id: 0,
          name: '',
          phone: '',
          roles: [],
          state: '',
          cityId: '',
          countryId: '',
          stateId: '');

      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.Profile_Url,
      ));

      profile = Response.fromMap(res["response"]);
      return profile;
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
