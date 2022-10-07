import 'package:studentz_link/Models/notifications.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class NotificationlistApiProvider {
  Future<NotificationModel> getnotificationlist() async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.notification_url,
      ));
      return NotificationModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
