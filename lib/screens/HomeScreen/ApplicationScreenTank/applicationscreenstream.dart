import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class ApplicationlistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getapplicationlistData(
      {String searchword = '',
      String college_id = '',
      String course_id = '',
      String batch_id = '',
      String status = ''}) async {
    await _getAll.addStream(repository
        .fetchapplicationlistdata(
            searchText: searchword,
            collegeid: college_id,
            courseid: course_id,
            batchid: batch_id,
            status: status)
        .asStream());
  }

  dispose() {
    _getAll.close();
  }
}
