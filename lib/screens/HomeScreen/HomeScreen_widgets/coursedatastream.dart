import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class CourselistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getCourselistData(
      {String searchword = '', required String college_id}) async {
    await _getAll.addStream(
        repository.fetchCourselist(college_id, searchword).asStream());
  }

  dispose() {
    _getAll.close();
  }
}
