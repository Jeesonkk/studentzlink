import 'package:studentz_link/Models/addedbymeshowmodel.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class TaskShowApiProvider {
  Future<AddedbymeShowModel> gettaskshow(taskid) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.task_show_url + taskid,
      ));

      return AddedbymeShowModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
