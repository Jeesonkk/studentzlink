import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/applicationlistmodel.dart';
import 'package:studentz_link/Models/documentlist.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/application_edit_screen3_doc_stream.dart';
import 'package:studentz_link/screens/HomeScreen/main_activity.dart';
import 'package:studentz_link/student_link_global_data.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentUploadForm extends StatefulWidget {
  int applicationid;
  DocumentUploadForm({Key? key, required this.applicationid}) : super(key: key);

  @override
  State<DocumentUploadForm> createState() => _DocumentUploadFormState();
}

class _DocumentUploadFormState extends State<DocumentUploadForm> {
  final globalKey = GlobalKey<ScaffoldState>();
  FilePickerResult? result;
  List<PlatformFile> files = [];
  List<TextEditingController> _controllers = [];
  final ShowLoader showLoader = ShowLoader();
  DocumentlistData doc_list = DocumentlistData();
  DocumentListModel docmodel =
      DocumentListModel(code: 0, response: [], status: '');

  FilePickerResult? resultadd;

  TextEditingController remarkcontroller = TextEditingController();

  String remarknew = '';

  int selectedindex = 0;
  var extension;

  String remark = '';
  ApplicationListModel applicationmodel =
      ApplicationListModel(code: 0, response: [], status: '');
  @override
  void initState() {
    doc_list = DocumentlistData();
    doc_list.getdocumentlistData(
        applicationid: widget.applicationid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ProgressHUD(
        child: Builder(
            builder: (context) => WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    key: globalKey,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Application Form',
                        style: TextStyle(
                            color: Colors.black54,
                            letterSpacing: .5,
                            fontSize: StudentLinkTheme().h1,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () async {
                              var getshare_parm = Uri(
                                scheme: 'https',
                                host: Apis.superlink,
                                path: Apis.baselink +
                                    'share-application/' +
                                    widget.applicationid.toString(),
                              );
                              print(getshare_parm);
                              RestApi().get(getshare_parm).then((value) async {
                                print(value['data']);
                                await Share.share(value['data'],
                                    subject:
                                        'Application No:${widget.applicationid}');
                              }).then((value) {
                                GlobalWidget().showToast(
                                    msg: 'Application Share Successfully');
                              }).catchError((onError) {
                                GlobalWidget().showToast(
                                    msg: 'Application Share Not Successfully');
                              });
                            },
                            icon: Icon(
                              Icons.share,
                              color: Colors.grey[900],
                            ))
                      ],
                    ),
                    body: RefreshIndicator(
                        color: StudentLinkTheme().primary1,
                        onRefresh: () => doc_list.getdocumentlistData(
                            applicationid: widget.applicationid.toString()),
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: StreamBuilder(
                                stream: doc_list.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data is DocumentListModel) {
                                      docmodel =
                                          snapshot.data as DocumentListModel;
                                    }
                                  } else if (snapshot.hasError) {
                                    return RefreshIndicator(
                                        color: StudentLinkTheme().primary1,
                                        onRefresh: () =>
                                            doc_list.getdocumentlistData(
                                                applicationid:
                                                    widget.applicationid),
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          child: Container(
                                            height: height,
                                            width: width,
                                            child: Image.asset(
                                              'assets/images/home_screen/nodata.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ));
                                  } else {
                                    return ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 50,
                                          ),
                                          width: width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Documents",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  letterSpacing: .5,
                                                  fontSize:
                                                      StudentLinkTheme().h3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return ListView(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 50,
                                        ),
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Documents",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: StudentLinkTheme().h1,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  resultadd = await FilePicker
                                                      .platform
                                                      .pickFiles(
                                                    allowMultiple: false,
                                                    type: FileType.custom,
                                                    allowedExtensions: [
                                                      'jpg',
                                                      'jpeg',
                                                      'pdf',
                                                      'doc',
                                                      'png'
                                                    ],
                                                  );
                                                  resultadd != null
                                                      ? showBarModalBottomSheet(
                                                          backgroundColor: Colors
                                                              .transparent,
                                                          context: context,
                                                          builder: (context) =>
                                                              Container(
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10))),
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                                  child:
                                                                      SafeArea(
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            'Enter Remark',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black87,
                                                                              letterSpacing: .5,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: StudentLinkTheme().h1,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          GlobalWidget()
                                                                              .DecorativeContainer(
                                                                            Container(
                                                                              padding: EdgeInsets.all(8),
                                                                              child: TextField(
                                                                                controller: remarkcontroller,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    remarknew = value;
                                                                                  });
                                                                                },
                                                                                decoration: InputDecoration(),
                                                                                autofocus: true,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Align(
                                                                              alignment: Alignment.bottomRight,
                                                                              child: GlobalWidget().submitButton(
                                                                                  buttontext: 'Add Document',
                                                                                  onPressed: () async {
                                                                                    remarknew != ''
                                                                                        ? adddocument(id: widget.applicationid.toString(), remarkindex: remarknew, document: resultadd!.files.single.path.toString()).then((value) {
                                                                                            Navigator.pushAndRemoveUntil(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => DocumentUploadForm(
                                                                                                          applicationid: widget.applicationid,
                                                                                                        )),
                                                                                                (route) => false);
                                                                                          })
                                                                                        : ShowLoader().failureshow(context, 'Enter Remark', () => Navigator.pop(context));
                                                                                  }))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )))
                                                      : SizedBox();
                                                },
                                                icon: Icon(Icons.add))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: docmodel.response.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            _controllers.add(
                                                new TextEditingController());
                                            extension = p.extension(docmodel
                                                .response[index].document);
                                            _controllers[index].text = docmodel
                                                .response[index].remarks;
                                            return Stack(
                                              children: [
                                                GlobalWidget()
                                                    .DecorativeContainer(
                                                  ListTile(
                                                      leading:
                                                          (extension ==
                                                                      '.jpg' ||
                                                                  extension ==
                                                                      '.png' ||
                                                                  extension ==
                                                                      '.jpeg')
                                                              ? Container(
                                                                  height: 80.0,
                                                                  width: 80.0,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      // Routing(
                                                                      //     context: context,
                                                                      //     To: DocViewer(
                                                                      //       extension,
                                                                      //       Document_Base_Url +
                                                                      //           state
                                                                      //               .document
                                                                      //               .response[index]
                                                                      //               .document
                                                                      //               .toString(),
                                                                      //       state.document.response[index]
                                                                      //           .remarks
                                                                      //           .toString(),
                                                                      //     ));
                                                                      showBarModalBottomSheet(
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              Container(
                                                                                height: 600,
                                                                                width: width,
                                                                                decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                  image: NetworkImage(Apis.Document_Base_Url + docmodel.response[index].document.toString()),
                                                                                )),
                                                                              ));
                                                                    },
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(Apis
                                                                              .Document_Base_Url +
                                                                          docmodel
                                                                              .response[index]
                                                                              .document
                                                                              .toString()),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 80.0,
                                                                  width: 80.0,
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    children: [
                                                                      SfPdfViewer.network(Apis
                                                                              .Document_Base_Url +
                                                                          docmodel
                                                                              .response[index]
                                                                              .document
                                                                              .toString()),
                                                                      CircleAvatar(
                                                                        radius:
                                                                            15,
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              showBarModalBottomSheet(
                                                                                  backgroundColor: Colors.transparent,
                                                                                  context: context,
                                                                                  builder: (context) => Container(
                                                                                        height: 600,
                                                                                        width: width,
                                                                                        child: SfPdfViewer.network(Apis.Document_Base_Url + docmodel.response[index].document.toString()),
                                                                                      ));
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.expand,
                                                                              size: 15,
                                                                            )),
                                                                      )
                                                                    ],
                                                                  )),
                                                      title: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                              '${docmodel.response[index].document.toString()}')),
                                                      subtitle: Container(
                                                        height: 60,
                                                        child: TextFormField(
                                                          onChanged: (value) {
                                                            //  print(file.name);
                                                          },
                                                          controller:
                                                              _controllers[
                                                                  index],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none,
                                                              ),
                                                            ),
                                                            hintText: 'Remark',
                                                            filled: true,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 16,
                                                                    left: 16,
                                                                    right: 16,
                                                                    bottom: 16),
                                                            fillColor: Colors
                                                                .grey[500],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                Positioned(
                                                    right: 1,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          var loging_parm = Uri(
                                                            scheme: 'https',
                                                            host:
                                                                Apis.superlink,
                                                            path: Apis
                                                                    .baselink +
                                                                'delete-application-document',
                                                            queryParameters: {
                                                              'id': docmodel
                                                                  .response[
                                                                      index]
                                                                  .id
                                                                  .toString()
                                                            },
                                                          );
                                                          RestApi()
                                                              .Post(loging_parm)
                                                              .then(
                                                                  (onValue) async {
                                                            GlobalWidget()
                                                                .showSnackBar(
                                                                    globalKey,
                                                                    onValue['response']
                                                                        [
                                                                        'msg']);
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            DocumentUploadForm(
                                                                              applicationid: widget.applicationid,
                                                                            )),
                                                                    (route) =>
                                                                        false);
                                                          }).catchError(
                                                                  (onError) {
                                                            GlobalWidget()
                                                                .showSnackBar(
                                                                    globalKey,
                                                                    onError
                                                                        .toString());
                                                          });
                                                        },
                                                        icon: Icon(
                                                            Icons.delete))),
                                                Positioned(
                                                    left: 1,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            selectedindex =
                                                                index;
                                                            remark =
                                                                _controllers[
                                                                        index]
                                                                    .text
                                                                    .toString();
                                                          });
                                                          if (_controllers[
                                                                      selectedindex]
                                                                  .text ==
                                                              docmodel
                                                                  .response[
                                                                      selectedindex]
                                                                  .remarks)
                                                            GlobalWidget()
                                                                .showToast(
                                                                    msg:
                                                                        'Please Update remarks also');
                                                          else
                                                            result =
                                                                await FilePicker
                                                                    .platform
                                                                    .pickFiles(
                                                              allowMultiple:
                                                                  false,
                                                              type: FileType
                                                                  .custom,
                                                              allowedExtensions: [
                                                                'jpg',
                                                                'jpeg',
                                                                'pdf',
                                                                'doc',
                                                                'png'
                                                              ],
                                                            );
                                                          updateDocs(
                                                                  id: docmodel
                                                                      .response[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  document: result!
                                                                      .files
                                                                      .single
                                                                      .path
                                                                      .toString(),
                                                                  remarkindex:
                                                                      remark)
                                                              .then((value) {
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            DocumentUploadForm(
                                                                              applicationid: widget.applicationid,
                                                                            )),
                                                                    (route) =>
                                                                        false);
                                                          }).onError((error,
                                                                  stackTrace) {});
                                                        },
                                                        icon: Icon(
                                                            Icons.update))),
                                                //Status
                                                Positioned(
                                                    right: 15,
                                                    bottom: 1,
                                                    child: Row(
                                                      children: [
                                                        docmodel.response[index]
                                                                    .status ==
                                                                0
                                                            ? Text(
                                                                'Pending',
                                                                style: TextStyle(
                                                                    color: StudentLinkTheme()
                                                                        .statusyellowcolor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : docmodel
                                                                        .response[
                                                                            index]
                                                                        .status ==
                                                                    1
                                                                ? Text(
                                                                    'Approved',
                                                                    style: TextStyle(
                                                                        color: StudentLinkTheme()
                                                                            .statusgreencolor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : docmodel.response[index]
                                                                            .status ==
                                                                        2
                                                                    ? Text(
                                                                        'Rejected',
                                                                        style: TextStyle(
                                                                            color:
                                                                                StudentLinkTheme().statusredcolor,
                                                                            fontWeight: FontWeight.bold),
                                                                      )
                                                                    : SizedBox()
                                                      ],
                                                    ))
                                              ],
                                            );
                                          }),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: width * 0.4,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      StudentLinkTheme()
                                                          .primary1),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.bold,
                                                fontSize: StudentLinkTheme().h3,
                                              ),
                                            ),
                                            onPressed: () {
                                              final progress =
                                                  ProgressHUD.of(context);
                                              progress!
                                                  .showWithText('Submitted...');
                                              GlobalData.clearAll();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainAcitivty(
                                                            choosedFragment: 2,
                                                          )),
                                                  (route) => false);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })))))));
  }

  Future<void> adddocument(
      {String? id, String? document, required String remarkindex}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalWidget().showToast(msg: 'Please Wait...');
    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/add-application-document");
    var request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    });
    request.fields['id'] = id!;
    request.files.add(await http.MultipartFile.fromPath('document', document!));
    request.fields['remarks'] = remarkindex;
    var response = await request.send();
    if (response.statusCode == 200) {
      print("document Added");
      GlobalWidget().showToast(msg: 'document Added...');
      setState(() {
        remarknew = '';
      });
      Navigator.pop(context);
    } else {
      GlobalWidget().showToast(msg: 'Document Not added...');
      Navigator.pop(context);
    }
  }

  Future<void> updateDocs(
      {String? id, String? document, required String remarkindex}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalWidget().showToast(msg: 'Please Wait...');
    var postUri = Uri.parse(
        "https://admission.studentzlink.com/api/v1/saleteam/update-application-document");
    var request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    });
    request.fields['id'] = id!;
    request.files.add(await http.MultipartFile.fromPath('document', document!));
    request.fields['remark'] = remarkindex;
    var response = await request.send();
    if (response.statusCode == 200) {
      print("document Uploaded");
      GlobalWidget().showToast(msg: 'Document Updated...');
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => ApplicationShow(
      //           applicationid: widget.application_id,
      //         )));
    } else {
      GlobalWidget().showToast(msg: 'Document Not Updated...');
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
