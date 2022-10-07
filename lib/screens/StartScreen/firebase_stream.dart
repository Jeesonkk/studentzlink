import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class Firebasestream {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  getfirebasetoken({firebasetoken}) async {
    await _getAll.addStream(
        repository.getfirebasetoken(firebasetoken: firebasetoken).asStream());
  }
}
