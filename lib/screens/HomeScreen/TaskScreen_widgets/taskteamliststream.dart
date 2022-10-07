import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class TeamlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getroleslistData({rolenamefroui}) async {
    await _getAll.addStream(
        repository.fetchteamlistdata(rolename: rolenamefroui).asStream());
  }
}
