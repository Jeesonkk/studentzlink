import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class AdmissionlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getadmissionlistData({String searchword = '', String status = ''}) async {
    await _getAll.addStream(repository
        .fetchadmissionlistdata(searchText: searchword, status: status)
        .asStream());
  }

  dispose() {
    _getAll.close();
  }
}
