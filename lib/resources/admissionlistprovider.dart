import 'package:studentz_link/Models/admissionlistmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class AdmissionlistApiProvider {
  Future<AdmissionListListModel> getadmissionlist({searchText, status}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.admissionlist,
          queryParameters: {
            'search': searchText,
            'status': status,
          }));
      return AdmissionListListModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
