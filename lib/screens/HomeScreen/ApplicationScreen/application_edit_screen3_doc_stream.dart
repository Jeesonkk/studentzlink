import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class DocumentlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getdocumentlistData({applicationid}) async {
    await _getAll.addStream(repository
        .fetchdocumentlistdata(applicationid: applicationid)
        .asStream());
  }
}
