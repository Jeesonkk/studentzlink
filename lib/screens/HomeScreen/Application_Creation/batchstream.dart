import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class BatchlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getbatchlistData({course_id}) async {
    await _getAll.addStream(
        repository.fetchbatchlistdata(courseid: course_id).asStream());
  }
}
