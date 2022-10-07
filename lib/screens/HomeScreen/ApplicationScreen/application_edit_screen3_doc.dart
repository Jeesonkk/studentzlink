import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentz_link/Models/documentlist.dart';
import 'package:studentz_link/REST/rest_api.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/application_edit_screen3_doc_stream.dart';
import 'package:studentz_link/screens/HomeScreen/ApplicationScreen/applications_edit_screen2.dart';
import 'package:studentz_link/student_link_global_widget.dart';
import 'package:studentz_link/utils/styles.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UpdateDocuments extends StatefulWidget {
  String application_id;
  UpdateDocuments({Key? key, required this.application_id}) : super(key: key);

  @override
  State<UpdateDocuments> createState() => _UpdateDocumentsState();
}

class _UpdateDocumentsState extends State<UpdateDocuments> {
  DocumentlistData doc_list = DocumentlistData();
  DocumentListModel docmodel =
      DocumentListModel(code: 0, response: [], status: '');
  List<TextEditingController> _controllers = [];
  final globalKey = GlobalKey<ScaffoldState>();

  var extension;

  int selectedindex = 0;

  String remark = '';

  FilePickerResult? result;

  bool visiblefile = false;
  FilePickerResult? resultadd;
  TextEditingController remarkcontroller = TextEditingController();

  String remarknew = '';
  @override
  void initState() {
    doc_list = DocumentlistData();
    doc_list.getdocumentlistData(applicationid: widget.application_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              iconSize: 20,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApplicationShow(
                              applicationid: widget.application_id,
                            )),
                    (route) => false);
              },
              icon: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          automaticallyImplyLeading: false,
          title: Text(
            'Update Documents',
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                fontSize: StudentLinkTheme().h2,
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
                        widget.application_id.toString(),
                  );
                  print(getshare_parm);
                  RestApi().get(getshare_parm).then((value) async {
                    print(value['data']);
                    await Share.share(value['data'],
                        subject: 'Application No:${widget.application_id}');
                  }).then((value) {
                    print(value);
                  }).catchError((onError) {});
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
                applicationid: widget.application_id),
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: StreamBuilder(
                    stream: doc_list.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is DocumentListModel) {
                          docmodel = snapshot.data as DocumentListModel;
                        }
                      } else if (snapshot.hasError) {
                        return RefreshIndicator(
                            color: StudentLinkTheme().primary1,
                            onRefresh: () => doc_list.getdocumentlistData(
                                applicationid: widget.application_id),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
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
                                      fontSize: StudentLinkTheme().h3,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      resultadd =
                                          await FilePicker.platform.pickFiles(
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) => Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 10),
                                                  child: SafeArea(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Enter Remark',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              letterSpacing: .5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  StudentLinkTheme()
                                                                      .h1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          GlobalWidget()
                                                              .DecorativeContainer(
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: TextField(
                                                                controller:
                                                                    remarkcontroller,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    remarknew =
                                                                        value;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: GlobalWidget()
                                                                  .submitButton(
                                                                      buttontext:
                                                                          'Add Document',
                                                                      onPressed:
                                                                          () {
                                                                        adddocument(
                                                                                id: widget.application_id,
                                                                                remarkindex: remarknew,
                                                                                document: resultadd!.files.single.path.toString())
                                                                            .then((value) {
                                                                          Navigator.pushAndRemoveUntil(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => UpdateDocuments(
                                                                                        application_id: widget.application_id,
                                                                                      )),
                                                                              (route) => false);
                                                                        });
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
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: docmodel.response.length,
                            itemBuilder: (BuildContext context, int index) {
                              _controllers.add(new TextEditingController());
                              extension = p
                                  .extension(docmodel.response[index].document);
                              _controllers[index].text =
                                  docmodel.response[index].remarks;
                              return Stack(
                                children: [
                                  GlobalWidget().DecorativeContainer(
                                    ListTile(
                                        leading: (extension == '.jpg' ||
                                                extension == '.png' ||
                                                extension == '.jpeg')
                                            ? Container(
                                                height: 90.0,
                                                width: 90.0,
                                                child: InkWell(
                                                  onTap: () {
                                                    showBarModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                Container(
                                                                  height: 600,
                                                                  width: width,
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
                                                                  )),
                                                                ));
                                                  },
                                                ),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        Apis.Document_Base_Url +
                                                            docmodel
                                                                .response[index]
                                                                .document
                                                                .toString()),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                ),
                                              )
                                            : Container(
                                                height: 90.0,
                                                width: 90.0,
                                                child: InkWell(
                                                  child: SfPdfViewer.network(
                                                      Apis.Document_Base_Url +
                                                          docmodel
                                                              .response[index]
                                                              .document
                                                              .toString()),
                                                  onTap: () {
                                                    showBarModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) =>
                                                            Container(
                                                              height: 600,
                                                              width: width,
                                                              child: SfPdfViewer.network(Apis
                                                                      .Document_Base_Url +
                                                                  docmodel
                                                                      .response[
                                                                          index]
                                                                      .document
                                                                      .toString()),
                                                            ));
                                                  },
                                                )),
                                        title: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                                '${docmodel.response[index].document.toString()}')),
                                        subtitle: Container(
                                          height: 60,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              //  print(file.name);
                                            },
                                            style:
                                                TextStyle(color: Colors.white),
                                            controller: _controllers[index],
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              hintText: 'Remark',
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              filled: true,
                                              contentPadding: EdgeInsets.only(
                                                  top: 16,
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 16),
                                              fillColor: Colors.grey[600],
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
                                              host: Apis.superlink,
                                              path: Apis.baselink +
                                                  'delete-application-document',
                                              queryParameters: {
                                                'id': docmodel
                                                    .response[index].id
                                                    .toString()
                                              },
                                            );
                                            RestApi()
                                                .Post(loging_parm)
                                                .then((onValue) async {
                                              GlobalWidget().showSnackBar(
                                                  globalKey,
                                                  onValue['response']['msg']);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDocuments(
                                                            application_id: widget
                                                                .application_id,
                                                          )),
                                                  (route) => false);
                                            }).catchError((onError) {
                                              GlobalWidget().showSnackBar(
                                                  globalKey,
                                                  onError.toString());
                                            });
                                          },
                                          icon: Icon(Icons.delete))),
                                  Positioned(
                                      left: 1,
                                      child: IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              selectedindex = index;
                                              remark = _controllers[index]
                                                  .text
                                                  .toString();
                                            });
                                            if (_controllers[selectedindex]
                                                    .text ==
                                                docmodel.response[selectedindex]
                                                    .remarks)
                                              GlobalWidget().showToast(
                                                  msg:
                                                      'Please Update remarks also');
                                            else
                                              result = await FilePicker.platform
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
                                            updateDocs(
                                                    id: docmodel
                                                        .response[index].id
                                                        .toString(),
                                                    document: result!
                                                        .files.single.path
                                                        .toString(),
                                                    remarkindex: remark)
                                                .then((value) {
                                              doc_list.getdocumentlistData(
                                                  applicationid:
                                                      widget.application_id);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDocuments(
                                                            application_id: widget
                                                                .application_id,
                                                          )),
                                                  (route) => false);
                                            }).catchError((onError) {
                                              GlobalWidget().showToast(
                                                  msg:
                                                      'Document Unable to upload');
                                            });
                                          },
                                          icon: Icon(
                                            Icons.update,
                                            color: StudentLinkTheme().primary1,
                                          ))),

                                  //Status
                                  Positioned(
                                      right: 15,
                                      bottom: 1,
                                      child: Row(
                                        children: [
                                          docmodel.response[index].status == 0
                                              ? Text(
                                                  'Pending:${docmodel.response[index].remarks}',
                                                  style: TextStyle(
                                                      color: StudentLinkTheme()
                                                          .statusyellowcolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : docmodel.response[index]
                                                          .status ==
                                                      1
                                                  ? Text(
                                                      'Approved:${docmodel.response[index].remarks}',
                                                      style: TextStyle(
                                                          color: StudentLinkTheme()
                                                              .statusgreencolor),
                                                    )
                                                  : docmodel.response[index]
                                                              .status ==
                                                          2
                                                      ? Text(
                                                          'Rejected:${docmodel.response[index].remarks}',
                                                          style: TextStyle(
                                                              color: StudentLinkTheme()
                                                                  .statusredcolor),
                                                        )
                                                      : SizedBox()
                                        ],
                                      ))
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: AnimatedContainer(
                              height: 45,
                              margin: EdgeInsets.only(
                                  right: 15, bottom: 0, top: 10),
                              duration: Duration(seconds: 1),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ApplicationShow(
                                                applicationid:
                                                    widget.application_id,
                                              )),
                                      (route) => false);
                                },
                                child: Text(
                                  '<= Application Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: .5,
                                    fontSize: StudentLinkTheme().h4,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            StudentLinkTheme().primary1),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                    ))),
                              ),
                            ),
                          )
                        ],
                      );
                    }))));
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
