import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class NotificationlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getnotificationlistData() async {
    await _getAll.addStream(repository.fetchNotificationslist().asStream());
  }
}
