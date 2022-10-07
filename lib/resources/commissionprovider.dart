import 'package:studentz_link/Models/commissionmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class CommissionlistApiProvider {
  Future<CommissionModel> getcommissionlist({required String status}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.commission,
          queryParameters: {
            'status': status,
          }));
      return CommissionModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
