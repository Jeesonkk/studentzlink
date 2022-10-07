import 'dart:async';

import 'package:studentz_link/resources/repository.dart';

class GetReceiptstream {
  Repository repository = Repository();
  final _getAll = StreamController.broadcast();

  Stream get stream => _getAll.stream;

  geteditreceipt({receipt}) async {
    await _getAll.addStream(repository.getreceipt(receipt: receipt).asStream());
  }
}
