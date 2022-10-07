import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class AdmissionshowData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getadmissionshowData({required String admissionid}) async {
    await _getAll.addStream(repository
        .fetchadmissionshowtdata(admissionid: admissionid)
        .asStream());
  }

  dispose() {
    _getAll.close();
  }
}
