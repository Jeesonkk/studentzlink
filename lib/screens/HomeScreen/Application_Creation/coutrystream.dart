import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class CountrylistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getcountryslistData() async {
    await _getAll.addStream(repository.fetchcountrylistdata().asStream());
  }
}
