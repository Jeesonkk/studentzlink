import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class GetDatestream {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getediteddate({editeddate}) async {
    await _getAll.addStream(repository.getdaet(date: editeddate).asStream());
  }
}
