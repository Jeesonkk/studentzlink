import 'package:studentz_link/Models/profile.dart';

class GlobalData {
  static Response myProfile = Response(
      id: 0,
      name: '',
      email: '',
      phone: '',
      address: '',
      country: '',
      state: '',
      city: '',
      bloodType: '',
      avatar: '',
      createdBy: '',
      createdAt: '',
      roles: [],
      cityId: '',
      countryId: '',
      stateId: '');
  //Push ?Notification
  static String fcmtoken = '';
  static String firebasetoken = '';
  //..................
  static String college_name = '';
  static String college_share = '';
  static String college_id = '';
  //College and course selection...........
  static String college_id_create = '';
  static String college_name_create = '';
  static String course_name_create = '';
  static String university_name_create = '';
  static String batch = '';
  static String course_id_create = '';
  static String batch_id_create = '';
  //Application Creation...................
  static String commission = '';
  static String AvatarImge = '';
  static String firstname = '';
  static String lastname = '';
  static String email = '';
  static dynamic phonenumber = '';
  static String dateofbirth = '';
  static String parentname = '';
  static String parentphone = '';
  static String country = '';
  static String state = '';
  static String district = '';
  static String feepaid = '0';
  static String address = '';
  static String receiptprrof = '';

  static String time = '';
  //Task page
  static String taskidbyme = '';
  static String taskidbyme0 = '';
  //Commissionrequest status......
  static bool requestsend = false;
  //Addedbymetaskedit..............
  static String addedbymetasknameedit = '';
  static String addedbymetaskdateedit = '';
  static String taskdateedit = '';
  static String description = '';
  static clearAll() {
    GlobalData.commission = '';
    GlobalData.AvatarImge = '';
    GlobalData.firstname = '';
    GlobalData.lastname = '';
    GlobalData.email = '';
    GlobalData.phonenumber = '';
    GlobalData.dateofbirth = '';
    GlobalData.parentname = '';
    GlobalData.parentphone = '';
    GlobalData.country = '';
    GlobalData.state = '';
    GlobalData.district = '';
    GlobalData.address = '';
    GlobalData.collegeidedit = '';
    GlobalData.courseidedit = '';
    GlobalData.batchidedit = '';
    GlobalData.batch_id_create = '';
    GlobalData.receiptprrof = '';
  }

  static clearAllEdit() {
    GlobalData.AvatarImgeedit = '';
    GlobalData.firstnameedit = '';
    GlobalData.lastnameedit = '';
    GlobalData.emailedit = '';
    GlobalData.phonenumberedit = '';
    GlobalData.dateofbirthedit;
    GlobalData.parentnameedit = '';
    GlobalData.parentphonenumberedit = '';
    GlobalData.countryedit = '';
    GlobalData.countryidedit = '';
    GlobalData.stateedit = '';
    GlobalData.stateidedit = '';
    GlobalData.cityedit = '';
    GlobalData.cityidedit = '';
    GlobalData.addressedit = '';
    GlobalData.courseidedit = '';
    GlobalData.collegeidedit = '';
    GlobalData.batchidedit = '';
  }

  //For Edit Application
  static String AvatarImgeedit = '';
  static String firstnameedit = '';
  static String lastnameedit = '';
  static String emailedit = '';
  static String phonenumberedit = '';
  static dynamic dateofbirthedit;
  static String parentnameedit = '';
  static String parentphonenumberedit = '';
  static String countryedit = '';
  static String countryidedit = '';
  static String stateedit = '';
  static String stateidedit = '';
  static String cityedit = '';
  static String cityidedit = '';
  static String addressedit = '';
  static String courseidedit = '';
  static String collegeidedit = '';
  static String batchidedit = '';
}
