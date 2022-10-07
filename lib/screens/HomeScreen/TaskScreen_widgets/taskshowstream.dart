import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class TaskshowtData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  gettaskshowData({taskid}) async {
    await _getAll
        .addStream(repository.fetchtaskshowdata(taskid: taskid).asStream());
  }
}
