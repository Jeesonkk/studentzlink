import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class CitylistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getcitieslistData({state_code}) async {
    await _getAll.addStream(
        repository.fetchcitieslistdata(state_code: state_code).asStream());
  }
}
