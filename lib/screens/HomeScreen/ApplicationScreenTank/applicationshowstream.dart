import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class ApplicationShowData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getapplicationshowData({
    required String applicationid,
  }) async {
    await _getAll.addStream(repository
        .fetchapplicationshowtdata(applicationid: applicationid)
        .asStream());
  }

  dispose() {
    _getAll.close();
  }
}
