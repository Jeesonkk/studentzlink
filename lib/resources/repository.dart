import 'package:studentz_link/Models/addedbymeshowmodel.dart';
import 'package:studentz_link/Models/admissionlistmodel.dart';
import 'package:studentz_link/Models/admissionshowmodel.dart';
import 'package:studentz_link/Models/applicationlistmodel.dart';
import 'package:studentz_link/Models/applicationshowmodel.dart';
import 'package:studentz_link/Models/batchModel.dart';
import 'package:studentz_link/Models/college.dart';
import 'package:studentz_link/Models/commissionmodel.dart';
import 'package:studentz_link/Models/course.dart';
import 'package:studentz_link/Models/dashboard.dart';
import 'package:studentz_link/Models/documentlist.dart';
import 'package:studentz_link/Models/getcities.dart';
import 'package:studentz_link/Models/getcountry.dart';
import 'package:studentz_link/Models/getstate.dart';
import 'package:studentz_link/Models/notifications.dart';
import 'package:studentz_link/Models/profile.dart';
import 'package:studentz_link/Models/rolelist.dart';
import 'package:studentz_link/Models/tasklist.dart';
import 'package:studentz_link/Models/teamlist.dart';
import 'package:studentz_link/resources/admissionlistprovider.dart';
import 'package:studentz_link/resources/admissionshowpovide.dart';
import 'package:studentz_link/resources/applicationlistprovider.dart';
import 'package:studentz_link/resources/applicatioshowprovider.dart';
import 'package:studentz_link/resources/batchprovider.dart';
import 'package:studentz_link/resources/collegesprovider.dart';
import 'package:studentz_link/resources/commissionprovider.dart';
import 'package:studentz_link/resources/courseprovider.dart';
import 'package:studentz_link/resources/dashboardprovider.dart';
import 'package:studentz_link/resources/dateprovider.dart';
import 'package:studentz_link/resources/documentlistprovider.dart';
import 'package:studentz_link/resources/firebaseprovider.dart';
import 'package:studentz_link/resources/getcitiespovider.dart';
import 'package:studentz_link/resources/getcountryprovider.dart';
import 'package:studentz_link/resources/getstateprovider.dart';
import 'package:studentz_link/resources/notificationprovider.dart';
import 'package:studentz_link/resources/profile_api_provider.dart';
import 'package:studentz_link/resources/receiptofapplicationfeeprovider.dart';
import 'package:studentz_link/resources/rolesprovider.dart';
import 'package:studentz_link/resources/tasklistprovider.dart';
import 'package:studentz_link/resources/taskshowprovider.dart';
import 'package:studentz_link/resources/teamlistprovider.dart';

class Repository {
  final profileApiProviderinitial = ProfileApiProvider();
  final collegelistproviderinitial = CollegelistApiProvider();
  final courselistproviderinitial = CourselistApiProvider();
  final notificationlist = NotificationlistApiProvider();
  final dashboarddatainitial = DashboarddataApiProvider();
  final roleslistdatainitial = RoleslistApiProvider();
  final teamlistdatainitial = TeamslistApiProvider();
  final coutrylistdatainitial = CountrylistApiProvider();
  final statelistdatinitial = StatelistApiProvider();
  final citieslistdatainitial = CitieslistApiProvider();
  final tasklistdatainitial = TasklistApiProvider();
  final taskshowdatainitial = TaskShowApiProvider();
  final applicationlistinitial = ApplicationlistApiProvider();
  final admissionlistprovider = AdmissionlistApiProvider();
  final commissionlistprovider = CommissionlistApiProvider();
  final admissionshowprovider = AdmissionShowApiProvider();
  final applicationshowprovider = ApplicationShowApiProvider();
  final documentproviderinitial = DocumentlistApiProvider();
  final batchstreamproviderinitial = BatchlistApiProvider();
  final dtateprovideinitial = DateProvider();
  final firebaseproviderinitial = FirebaseProvider();
  final receiptproviderinitial = ReceiptoffeeProvider();

  ///User profile
  Future<Response> fetchProfile() => profileApiProviderinitial.getUserProfile();
  //getcollegelist
  Future<CollegeModel> fetchCollegelist(String searcchtext) =>
      collegelistproviderinitial.getcollegelist(searcchtext);
  //getcourselist
  Future<CourseModel> fetchCourselist(String college_id, searcchtext) =>
      courselistproviderinitial.getcourselist(college_id, searcchtext);
  //getnotification.......
  Future<NotificationModel> fetchNotificationslist() =>
      notificationlist.getnotificationlist();
  //getdashboarddata............
  Future<DashBoardModel> fetchDashboarddata() =>
      dashboarddatainitial.getdashboarddata();
  //roleslistdata............
  Future<RoleListModel> fetchrolelistdata() =>
      roleslistdatainitial.getrolelist();
  //getteamlist......
  Future<TeamListModel> fetchteamlistdata({rolename}) =>
      teamlistdatainitial.getteamlist(rolename);
  //getcountries..............
  Future<CountryModel> fetchcountrylistdata() =>
      coutrylistdatainitial.getcountrylist();
  //getstates..............
  Future<StateModel> fetchstatelistdata({country_code}) =>
      statelistdatinitial.getstatelist(country_code);
  //getcities..............
  Future<CityModel> fetchcitieslistdata({state_code}) =>
      citieslistdatainitial.getcitylist(state_code);
  //gettasklist.
  Future<TaskModel> fetchtasklistdata({askstatus, created_by, searchtext}) =>
      tasklistdatainitial.gettasklist(askstatus, created_by, searchtext);
  //showtask....
  Future<AddedbymeShowModel> fetchtaskshowdata({taskid}) =>
      taskshowdatainitial.gettaskshow(taskid);
  //Applicationlist.........
  Future<ApplicationListModel> fetchapplicationlistdata(
          {searchText, collegeid, courseid, batchid, status}) =>
      applicationlistinitial.getapplicationlist(
          searchText: searchText,
          collegeid: collegeid,
          courseid: courseid,
          batchid: batchid,
          status: status);
  //admissionlist...............
  Future<AdmissionListListModel> fetchadmissionlistdata({searchText, status}) =>
      admissionlistprovider.getadmissionlist(
          searchText: searchText, status: status);
  //Commission list.................
  Future<CommissionModel> fetchcommissionlistdata({status}) =>
      commissionlistprovider.getcommissionlist(status: status);
  //AdmissionShow................
  Future<AdmissionShowModel> fetchadmissionshowtdata(
          {required String admissionid}) =>
      admissionshowprovider.getadmissionshow(admissionid: admissionid);
  //ApplicationShow................
  Future<ApplicationShowModel> fetchapplicationshowtdata(
          {required String applicationid}) =>
      applicationshowprovider.getapplicationshow(applicationid: applicationid);
  //document_list_show................
  Future<DocumentListModel> fetchdocumentlistdata(
          {required String applicationid}) =>
      documentproviderinitial.getdocumentlist(application_id: applicationid);
  //batch_list_show................
  Future<BatchModel> fetchbatchlistdata({required String courseid}) =>
      batchstreamproviderinitial.getbatchlist(courseid);
  //setDate.....
  Future getdaet({required String date}) =>
      dtateprovideinitial.Dateset(editeddate: date);
  //SetFirebase...........
  Future getfirebasetoken({required String firebasetoken}) =>
      firebaseproviderinitial.Firebaseset(firebase_token: firebasetoken);
  //setReceiptStream............
  Future getreceipt({required dynamic receipt}) =>
      receiptproviderinitial.Receiptstreamsetset(receipt: receipt);
}
