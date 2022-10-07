


import 'package:studentz_link/Models/documentlist.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/REST/rest_api.dart';

class DocumentlistApiProvider {
  Future<DocumentListModel> getdocumentlist({application_id}) async {
    try {
      Map<String, dynamic> res = await RestApi().get(Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + Apis.Document_list_url+application_id,
      ));

      return DocumentListModel.fromMap(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}