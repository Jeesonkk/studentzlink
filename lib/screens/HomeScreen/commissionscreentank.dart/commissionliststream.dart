


import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class CommissionlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getCommissionlistData(String status) async {
    await _getAll.addStream(repository.fetchcommissionlistdata(status: status).asStream());
  }

  dispose() {
    _getAll.close();
  }
}
