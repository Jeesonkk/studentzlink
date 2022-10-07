import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class CollegelistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getCollegelistData(String searchword) async {
    await _getAll.addStream(repository.fetchCollegelist(searchword).asStream());
  }

  dispose() {
    _getAll.close();
  }
}
