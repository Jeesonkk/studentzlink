import 'package:studentz_link/Models/admissionshowmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class AdmissionShowApiProvider {
  Future<AdmissionShowModel> getadmissionshow(
      {required String admissionid}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.admissionshow + admissionid,
      ));
      return AdmissionShowModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
