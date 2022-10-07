import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/REST/app_exceptions.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/student_links_strings.dart';

class RestApi {
  Future checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(Apis.superlink);

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  //get..........................................................
  Future<T> get<T>(Uri get_parm, [String? t]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api Get, url $url');
    T responseJson;
    try {
      final response = await http.get(get_parm, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("RESPONSE $t :: ${response.body}");
      responseJson = _returnResponse(response);
    } on RestException catch (e) {
      throw e;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  //post........
  Future<T> Post<T>(Uri parm, [var body]) async {
    print(body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    T responseJson;
    try {
      final response = await http.post(
        parm,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      responseJson = _returnResponse(response);
    } on RestException catch (e) {
      print('Rest Exception');
      throw e.message;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(Uri parm, [var body]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(
        parm,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
//    print(responseJson.toString());
    return responseJson;
  }

  //mutipart
  Future<T> multiPart<T>(String url,
      {required Map<String, dynamic> params}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('Api multipart, url $url $params');
    T responseJson;
    if (token != null) {
      try {
        print("MultipartFile call--------------");
        var uri = Uri.parse(url);
        Map<String, String> headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
        };
        http.MultipartRequest request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
        request.fields.addAll(params["fields"]);
        if (params['file'] != null || params['file'] != 'hi') {
          Map<String, dynamic> _file = params['file'];
          http.MultipartFile multipartFile;
          _file.entries.forEach((element) async {
            if (element.value != null && element.value != 1) {
              var stream = new http.ByteStream(
                  Stream.castFrom(element.value?.openRead()));
              var length = await (element.value as File)?.length();
              multipartFile = new http.MultipartFile(
                  element.key, stream, length!,
                  filename: basename(element.value?.path));
              print("VALUE : $length ${element.key}, ${element.value}");
              request.files.add(multipartFile);
            }
          });
          /*   for (var entry in _file.entries) {
            var stream = new http.ByteStream(Stream.castFrom(entry.value?.openRead()));
            var length = await (entry.value as File)?.length();
            multipartFile =
                new http.MultipartFile(entry.key, stream, length, filename: basename(entry.value?.path));
            print("VALUE : $length ${entry.key}, ${entry.value}");
            request.files.add(multipartFile);
          }*/
        }
        var streamResponse = await request.send();
        //Response response = jsonDecode(await streamResponse.stream.transform(utf8.decoder).join());

        var onData = await streamResponse.stream.transform(utf8.decoder).first;
        print("dynamicCallApi RESPONSE : $onData");
        responseJson = _returnResponse<Map>(json.decode(onData.toString()));
        return responseJson;
      } on SocketException {
        print('No Internet');
        throw FetchDataException('No Internet connection');
      }
    } else {
      throw Exception('Your Token has Expired!.Please signin again.');
    }
  }

  //master
  Future<Map> GetPaymentMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri(
        scheme: 'https',
        host: Apis.superlink,
        path: Apis.baselink + "master",
      ),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      var Response = jsonDecode(response.body);
      return Response;
    } else {
      var Response = jsonDecode(response.body);
      print('status err');
      return Response;
    }
  }
}

//responses...
dynamic _returnResponse<T>(T response) {
  print('respose-------------- $T');
  if (response is http.Response) {
    //  print(response.body);
    print('statusCode------------- ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print("responseJson : $responseJson");

        return responseJson;
      case 404:
        //throw  FetchDataErrorException(json.decode(response.body));
        throw BadRequestException(
            'Something went wrong : ${response.statusCode}');
      case 400:
        throw BadRequestException(json.decode(response.body));
      case 401:

      case 403:
        throw UnauthorisedException(json.decode(response.body));
      case 500:
        /* default:
        GlobalWidgets().showToast(msg: CoupledStrings.serverDown);*/
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  } else if (response is Map<String, dynamic>) {
    print("MAP :::");
    print(response);
    switch (response["code"]) {
      case 200:
        var responseJson = response["response"];
        print("responseJson : $responseJson");
        return responseJson;
      case 404:
      case 400:
        throw BadRequestException(response["response"]);
      case 401:
      case 403:
        throw UnauthorisedException(response["response"]);
      case 500:
      default:
        GlobalWidget().showToast(msg: StudentLinkStrings.serverDown);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response["code"]}');
    }
  }
}

class Apis {
  static String superlink = 'admission.studentzlink.com';
  static String baselink = '/api/v1/saleteam/';
  static String avatarbaseurl =
      'https://admission.studentzlink.com/media/avatar/';
  static String Logo_Base_Url =
      'https://admission.studentzlink.com/media/logo/';
  static String Document_Base_Url =
      'https://admission.studentzlink.com/media/document/';
  static String loginurl = "${superlink + baselink + 'loginotp'}";
  static String Profile_Url = 'profile';
  static String college_url = 'college';
  static String Course_Url = 'course';
  static String batchurl = 'batches/';
  static String Logout_Url = 'logout';
  static String notification_url = "notification";
  static String dashboard_url = 'get-dashboard';
  static String role_url = 'role';
  static String team_url = 'team';
  static String addtask = 'task';
  static String Country_url = 'get-countries';
  static String State_url = 'get-states/';
  static String District_url = 'get-cities/';
  static String task_url = 'task';
  static String task_show_url = 'task/';
  static String applicationlist = 'application';
  static String admissionlist = 'admission';
  static String commission = 'commission';
  static String admissionshow = 'admission/';
  static String applicationshowurl = 'application/';
  static String commission_url = 'commission';
  static String AdmissionList_Url = 'admission';
  static String Document_list_url = 'application-documents/';
}
