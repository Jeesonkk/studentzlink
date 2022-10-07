import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class RoleslistData {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getroleslistData() async {
    await _getAll.addStream(repository.fetchrolelistdata().asStream());
  }
}
