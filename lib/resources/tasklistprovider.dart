import 'package:studentz_link/Models/tasklist.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class TasklistApiProvider {
  Future<TaskModel> gettasklist(taskstatus, created_by, searchtext) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
          scheme: 'https',
          host: Apis.superlink,
          path: Apis.baselink + Apis.task_url,
          queryParameters: {
            'status': taskstatus,
            'created_by': created_by,
            'search': searchtext
          }));

      return TaskModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
