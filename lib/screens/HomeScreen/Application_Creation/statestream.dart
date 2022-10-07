import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class StatelistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getstatelistData({country_code}) async {
    await _getAll.addStream(
        repository.fetchstatelistdata(country_code: country_code).asStream());
  }
}
