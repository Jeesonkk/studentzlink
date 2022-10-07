import 'package:studentz_link/Models/batchModel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class BatchlistApiProvider {
  Future<BatchModel> getbatchlist(courseid) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.batchurl + courseid,
      ));
      return BatchModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
