import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class DashboardData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getdashboardData() async {
    await _getAll.addStream(repository.fetchDashboarddata().asStream());
  }
}
