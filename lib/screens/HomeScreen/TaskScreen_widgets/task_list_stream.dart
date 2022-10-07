import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class TasklistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  gettasklistData({taskstatus, created_by, search}) async {
    await _getAll.addStream(repository
        .fetchtasklistdata(
            askstatus: taskstatus, created_by: created_by, searchtext: search)
        .asStream());
  }
}
