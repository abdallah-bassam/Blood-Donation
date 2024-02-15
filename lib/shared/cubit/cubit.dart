import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/screens/donor_home_layout/donor_home.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import '../../screens/admin_home_layout/admin_home_layout.dart';
import '../../screens/donor_home_layout/donor_home_layout.dart';
import '../reusable_components.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;

enum Gender { male, female }

enum Hospital {
  AlBashirHospital,
  UniversityofJordanHospital,
  PrinceHamzahHospital
}

List<String> hospitalsForAddPatients = [
  'Al-Bashir Hospital',
  'Prince Hamzah Hospital',
  'University of Jordan Hospital',
];

class BloodDonationCubit extends Cubit<BloodDonationStates> {
  BloodDonationCubit() : super(InitialAppState());

  static BloodDonationCubit get(context) => BlocProvider.of(context);
  IconData suffixPassword = Icons.visibility_off;
  IconData suffixConfirmPassword = Icons.visibility_off;
  IconData rememberMeIcon = Icons.check_box_outline_blank_sharp;
  bool isPassword = true;
  bool isConfirmPassword = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  Gender? selectedGender;
  bool successLogin = false;
  int? donorId;

  int currentIndexDonor = 0;
  int screen = 0;
  int selectedIndex = 0;
  TextEditingController dateDonateController = TextEditingController();
  TextEditingController timeDonateController = TextEditingController();
  int bloodTypeListForPatients = 0;
  List<dynamic>? patientModels = [];
  List<dynamic>? searchedPatientModels = [];
  List<dynamic>? donorModels = [];
  bool searchedPatientNotFound = false;

  List<dynamic>? donorsForPatient = [];

  List<dynamic>? donorModelsAPlus = [];
  List<dynamic>? donorModelsAMinus = [];
  List<dynamic>? donorModelsBPlus = [];
  List<dynamic>? donorModelsBMinus = [];
  List<dynamic>? donorModelsABPlus = [];
  List<dynamic>? donorModelsABMinus = [];
  List<dynamic>? donorModelsOPlus = [];
  List<dynamic>? donorModelsOMinus = [];

  List<dynamic>? patientModelsAPlus = [];
  List<dynamic>? patientModelsAMinus = [];
  List<dynamic>? patientModelsBPlus = [];
  List<dynamic>? patientModelsBMinus = [];
  List<dynamic>? patientModelsABPlus = [];
  List<dynamic>? patientModelsABMinus = [];
  List<dynamic>? patientModelsOPlus = [];
  List<dynamic>? patientModelsOMinus = [];
  List<dynamic>? patientModelsForNotifications = [];
  List<dynamic>? historyOfDonations = [];

  List<dynamic> patientModelsAlBashirHospital = [];
  List<dynamic> patientModelsPrinceHamzahHospital = [];
  List<dynamic> patientModelsUniversityOfJordanHospital = [];

  Future<void> userLogin({required String email, required String password, required BuildContext context}) async {
    emit(LoadingLoginState());

    // Save a reference to the context
    final loginContext = context;

    DioHelper.postToDatabase(
      url: 'api/login',
      data: {'email': email, 'password': password},
    ).then((value) {
      if (value.data['Status']) {
        DioHelper.getDatabase(url: 'api/Donors/id/${value.data['id']}').then((value) {
          userDonor = value.data;
          userDonor['username'].toString().contains('admin') ? Navigator.push(
            loginContext,
            MaterialPageRoute(builder: (loginContext) => AdminHomeLayout()),
          ) : Navigator.push(
            loginContext,
            MaterialPageRoute(builder: (loginContext) => DonorHomeLayout()),
          );
        }).catchError((error) {
          print(error.toString());
        });
      }
      else {
        showDialog(
          context: loginContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: null,
              content: sharedText(
                text: 'Email or Password Not Correct',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Try again'),
                ),
              ],
            );
          },
        );
      }
      emit(SuccessUserLoginState());
    }).catchError((error) {});
  }

  void changeSuccessLogin(bool index) {
    successLogin = index;
    emit(ChangeSuccessLoginState());
  }

  void getUserData(donorId){

  }



  void donorSignUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required int phoneNumber,
      required int age,
      required String gender,
      required String bloodType}) {
    emit(LoadingSignUpState());
    DioHelper.postToDatabase(url: 'api/Donors', data: {
      "username": "$email",
      "password": "$password",
      "first_Name": "$firstName",
      "last_Name": "$lastName",
      "phone": phoneNumber,
      "age": age,
      "gender": "$gender",
      "blood_Type": "$bloodType"
    }).then((value) {
      emit(SuccessDonorSignUpState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedDonorSignUpState(error: error.toString()));
    });
  }


  void donorEditProfile(
      {required String email,
        required String password,
        required String firstName,
        required String lastName,
        required int phoneNumber,
        required int age,
        required String gender,
        required String bloodType,
        required donor_id
      }) {
    emit(LoadingSignUpState());
    DioHelper.putToDatabase(url: 'api/Donors', data: {
      "username": "$email",
      "password": "$password",
      "first_Name": "$firstName",
      "last_Name": "$lastName",
      "phone": phoneNumber,
      "age": age,
      "gender": "$gender",
      "blood_Type": "$bloodType",
      "donor_id": donor_id
    }).then((value) {
      emit(SuccessDonorEditProfileState());
    }).catchError((error) {
      emit(FailedDonorEditProfileState());
    });
  }

  void getAllPatients() {
    DioHelper.getDatabase(url: 'api/Patients/all').then((value) async {
      patientModels = value.data;
      emit(SuccessGetAllPatientsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllPatientsState());
    });
  }

  void deleteOldPatients() async
  {

    for (var patient in patientModels!) {
      int x = int.tryParse(patient['first_Date'].toString().substring(4,6))??0;
      int y = int.tryParse(patient['last_Date'].toString().substring(4,6))??0;
      if((y-x) <0)
      {
        DioHelper.deleteFromDatabase(url: 'api/Patients/Delete/${patient['patient_Id']}');
      }
    }
    emit(DeleteOldPatientsState());
  }

  void getPatientsForDonor(patientId) {
    DioHelper.getDatabase(url: 'api/Patients/id/${patientId}').then((value) async {
      historyOfDonations!.add(value.data);
      emit(SuccessGetAllPatientsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllPatientsState());
    });
  }

  void deletePatientFromDonor(model) {
    historyOfDonations!.remove(model);
    emit(DeletePatientFromDonorState());
  }

  void getPatientsBySearch({required firstName}) {
    searchedPatientModels = [];
    DioHelper.getDatabase(url: 'api/Patients/Fname/$firstName')
        .then((value) async {
      searchedPatientModels = await value.data;
      if (searchedPatientModels!.isEmpty) searchedPatientNotFound = true;
      if (searchedPatientModels!.isNotEmpty) searchedPatientNotFound = false;
      emit(SuccessGetAllPatientsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllPatientsState());
    });
  }

  void changeSearchedPatientNotFound() {
    searchedPatientModels = [];
    searchedPatientNotFound = false;
    emit(ChangeSearchedPatientNotFoundState());
  }

  void postDonorToPatient({required donorId, required patientId}) {
    DioHelper.putToDatabase(url: 'Patient/Donor/$patientId/Donor/$donorId')
        .then((value) async {
      emit(SuccessPostDonorToPatient());
    }).catchError((error) {
      print(error.toString());
      emit(FailedPostDonorToPatient());
    });
  }

  Future<void> getDonorsForPatient({required int patientId}) async {
    DioHelper.getDatabase(url: 'api/Patients/id/$patientId')
        .then((value) async {
      donorsForPatient = await value.data['donorS'];
      emit(SuccessGetDonorsForPatientState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetDonorsForPatientState());
    });
  }

  void addPatient(
      {required String firstDate,
      required String lastDate,
      required String firstName,
      required String lastName,
      required String nameHospital,
      required int age,
      required String gender,
      required String bloodType}) {
    DioHelper.postToDatabase(url: 'api/Patients', data: {
      "first_Date": "$firstDate",
      "last_Date": "$lastDate",
      "first_Name": "$firstName",
      "last_Name": "$lastName",
      "name_Hospital": nameHospital,
      "age": age,
      "gender": "$gender",
      "blood_Type": "$bloodType"
    }).then((value) {
      emit(SuccessAddPatientState());
    }).catchError((error) {
      emit(FailedAddPatientState());
    });
  }

  void getAllDonors() {
    DioHelper.getDatabase(url: 'api/Donors/all').then((value) async {
      donorModels = await value.data;
      emit(SuccessGetAllDonorsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllDonorsState());
    });
  }

  void getDonorsByBloodType({required bloodType}) {
    DioHelper.getDatabase(url: 'api/Donors/Type/$bloodType')
        .then((value) async {
      if (bloodType == 'A+') donorModelsAPlus = await value.data;
      if (bloodType == 'A-') donorModelsAMinus = await value.data;
      if (bloodType == 'B+') donorModelsBPlus = await value.data;
      if (bloodType == 'B-') donorModelsBMinus = await value.data;
      if (bloodType == 'AB+') donorModelsABPlus = await value.data;
      if (bloodType == 'AB-') donorModelsABMinus = await value.data;
      if (bloodType == 'O+') donorModelsOPlus = await value.data;
      if (bloodType == 'O-') donorModelsOMinus = await value.data;
      emit(SuccessGetAllDonorsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllDonorsState());
    });
  }

  void getPatientsByBloodType({required bloodType}) {
    DioHelper.getDatabase(url: 'api/Patients/Type/$bloodType')
        .then((value) async {
      if (bloodType == 'A+') {
        patientModelsAPlus = await value.data;
      }
      if (bloodType == 'A-') {
        patientModelsAMinus = await value.data;
      }
      if (bloodType == 'B+') {
        patientModelsBPlus = await value.data;
      }
      if (bloodType == 'B-') {
        patientModelsBMinus = await value.data;
      }
      if (bloodType == 'AB+') {
        patientModelsABPlus = await value.data;
      }
      if (bloodType == 'AB-') {
        patientModelsABMinus = await value.data;
      }
      if (bloodType == 'O+') {
        patientModelsOPlus = await value.data;
      }
      if (bloodType == 'O-') {
        patientModelsOMinus = await value.data;
      }
      emit(SuccessGetAllPatientsState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetAllPatientsState());
    });
  }

  void getPatientsForNotifications({required bloodType}) async {
    if (bloodType == 'A+') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/A+');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB+');

      patientModelsForNotifications = [...response1.data, ...response2.data];
    }
    if (bloodType == 'A-') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB-');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/A-');

      patientModelsForNotifications = [...response1.data, ...response2.data];
    }
    if (bloodType == 'B+') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/B+');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB+');

      patientModelsForNotifications = [...response1.data, ...response2.data];
    }
    if (bloodType == 'B-') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB-');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/B-');

      patientModelsForNotifications = [...response1.data, ...response2.data];
    }
    if (bloodType == 'AB+') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB+');

      patientModelsForNotifications = response1.data;
    }
    if (bloodType == 'AB-') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB-');
      patientModelsForNotifications = response1.data;
    }
    if (bloodType == 'O+') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB+');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/A+');
      final response3 = await DioHelper.getDatabase(url: 'api/Patients/Type/O+');
      final response4 = await DioHelper.getDatabase(url: 'api/Patients/Type/B+');

      patientModelsForNotifications = [...response1.data, ...response2.data, ...response3.data, ...response4.data];
    }
    if (bloodType == 'O-') {
      final response1 = await DioHelper.getDatabase(url: 'api/Patients/Type/AB+');
      final response2 = await DioHelper.getDatabase(url: 'api/Patients/Type/A+');
      final response3 = await DioHelper.getDatabase(url: 'api/Patients/Type/O+');
      final response4 = await DioHelper.getDatabase(url: 'api/Patients/Type/B+');
      final response5 = await DioHelper.getDatabase(url: 'api/Patients/Type/O-');
      final response6 = await DioHelper.getDatabase(url: 'api/Patients/Type/B-');
      final response7 = await DioHelper.getDatabase(url: 'api/Patients/Type/O-');
      final response8 = await DioHelper.getDatabase(url: 'api/Patients/Type/A-');

      patientModelsForNotifications = [...response1.data, ...response2.data, ...response3.data, ...response4.data, ...response5.data, ...response6.data, ...response7.data, ...response8.data];
    }
    emit(SuccessGetAllPatientsState());
  }




  bool showInnerListForHospitalA = false;
  List<Widget> innerListForHospitalA = [];
  IconData iconInHospitalAList = Icons.arrow_circle_down_rounded;

  void changeIconInHospitalAList() {
    if (iconInHospitalAList == Icons.arrow_circle_down_rounded) {
      iconInHospitalAList = Icons.arrow_circle_up_rounded;
    } else {
      iconInHospitalAList = Icons.arrow_circle_down_rounded;
    }
    emit(ChangeIconInHospitalAListState());
  }

  void addToInnerListForHospitalA(BuildContext context) async {
    innerListForHospitalA = [];
    await DioHelper.getDatabase(url: 'api/Patients/Hospital/Al-Bashir Hospital')
        .then((value) {
      patientModelsAlBashirHospital = value.data;
    });
    for (int index = 0; index < patientModelsAlBashirHospital.length; index++) {
      innerListForHospitalA.add(buildPatientItem(
        context: context,
        patientModel: patientModelsAlBashirHospital[index],
      ));
    }
    emit(AddToInnerListForHospitalAState());
  }

  void changeShowInnerListForHospitalA() {
    showInnerListForHospitalA = !showInnerListForHospitalA;
    emit(ChangeShowInnerListHospitalAState());
  }

  bool showInnerListForHospitalB = false;
  List<Widget> innerListForHospitalB = [];
  IconData iconInHospitalBList = Icons.arrow_circle_down_rounded;

  void changeIconInHospitalBList() {
    if (iconInHospitalBList == Icons.arrow_circle_down_rounded) {
      iconInHospitalBList = Icons.arrow_circle_up_rounded;
    } else {
      iconInHospitalBList = Icons.arrow_circle_down_rounded;
    }
    emit(ChangeIconInHospitalBListState());
  }

  void addToInnerListForHospitalB(BuildContext context) async {
    innerListForHospitalB = [];
    await DioHelper.getDatabase(
            url: 'api/Patients/Hospital/Prince Hamzah Hospital')
        .then((value) {
      patientModelsPrinceHamzahHospital = value.data;
    });
    for (int index = 0;
        index < patientModelsPrinceHamzahHospital.length;
        index++) {
      innerListForHospitalB.add(buildPatientItem(
        context: context,
        patientModel: patientModelsPrinceHamzahHospital[index],
      ));
    }
    emit(AddToInnerListForHospitalBState());
  }

  void changeShowInnerListForHospitalB() {
    showInnerListForHospitalB = !showInnerListForHospitalB;
    emit(ChangeShowInnerListHospitalBState());
  }

  bool showInnerListForHospitalC = false;
  List<Widget> innerListForHospitalC = [];
  IconData iconInHospitalCList = Icons.arrow_circle_down_rounded;

  void changeIconInHospitalCList() {
    if (iconInHospitalCList == Icons.arrow_circle_down_rounded) {
      iconInHospitalCList = Icons.arrow_circle_up_rounded;
    } else {
      iconInHospitalCList = Icons.arrow_circle_down_rounded;
    }
    emit(ChangeIconInHospitalCListState());
  }

  void addToInnerListForHospitalC(BuildContext context) async {
    innerListForHospitalC = [];
    await DioHelper.getDatabase(
            url: 'api/Patients/Hospital/University of Jordan Hospital')
        .then((value) {
      patientModelsUniversityOfJordanHospital = value.data;
    });
    for (int index = 0;
        index < patientModelsUniversityOfJordanHospital.length;
        index++) {
      innerListForHospitalC.add(buildPatientItem(
        context: context,
        patientModel: patientModelsUniversityOfJordanHospital[index],
      ));
    }
    emit(AddToInnerListForHospitalCState());
  }

  void changeShowInnerListForHospitalC() {
    showInnerListForHospitalC = !showInnerListForHospitalC;
    emit(ChangeShowInnerListHospitalCState());
  }

  void changeBloodTypeListForDonate(index) {
    bloodTypeListForPatients = index;
    emit(ChangeBloodTypeListState());
  }

  void changeSelectedItemForDonate(index) {
    selectedIndex = index;
    emit(ChangeSelectedItemState());
  }

  void changeDonorHomeScreens(index) {
    screen = index;
    emit(ChangeDonorHomeScreensState());
  }

  void changePasswordIcon() {
    if (suffixPassword == Icons.visibility) {
      suffixPassword = Icons.visibility_off;
    } else {
      suffixPassword = Icons.visibility;
    }
    emit(ChangePasswordIconState());
  }

  void changeIsPassword() {
    isPassword = !isPassword;
    emit(ChangeIsPasswordState());
  }

  void changeConfirmPasswordIcon() {
    if (suffixConfirmPassword == Icons.visibility) {
      suffixConfirmPassword = Icons.visibility_off;
    } else {
      suffixConfirmPassword = Icons.visibility;
    }
    emit(ChangeConfirmPasswordIconState());
  }

  void changeIsConfirmPassword() {
    isConfirmPassword = !isConfirmPassword;
    emit(ChangeIsConfirmPasswordState());
  }

  void changeRememberMeIcon() {
    if (rememberMeIcon == Icons.check_box) {
      rememberMeIcon = Icons.check_box_outline_blank_sharp;
    } else {
      rememberMeIcon = Icons.check_box;
    }
    emit(ChangeRememberMeIconState());
  }

  void changeIndexOfBottomNavBarDonor(index) {
    currentIndexDonor = index;
    emit(ChangeIndexOfBottomNavBarDonorState());
  }

  void changeSelectedGender(value) {
    selectedGender = value;
    emit(ChangeSelectedGenderState());
  }

  // Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin

  int adminScreen = 0;
  int currentIndexAdmin = 0;
  int selectedIndexAddPatient = -1;
  int selectedIndexDonors = 0;
  int bloodTypeListForDonors = 0;
  int selectedIndexSignUp = -1;
  String bloodTypeForAddPatient = '';
  IconData iconInPatientList = Icons.arrow_downward;
  Gender? selectedGenderAddPatient;
  Hospital? selectedHospitalAddPatient;
  String selectedGenderAddPatientAsString = '';
  String selectedHospitalAddPatientAsString = '';
  TextEditingController searchPatientsForAdminContoller =
      TextEditingController();
  int donationMadeForPatientId = 0;
  String donationMadeForPatientName = '';
  TextEditingController firstNamePatientController = TextEditingController();
  TextEditingController lastNamePatientController = TextEditingController();
  TextEditingController agePatientController = TextEditingController();
  TextEditingController firstDateToDonateController = TextEditingController();
  TextEditingController lastDateToDonateController = TextEditingController();
  TextEditingController hospitalWorkingTimeFromController =
      TextEditingController();
  TextEditingController hospitalWorkingTimeToController =
      TextEditingController();

  void changeIndexOfBottomNavBarAdmin(index) {
    currentIndexAdmin = index;
    emit(ChangeIndexOfBottomNavBarAdminState());
  }

  void changeAdminHomeScreens(index) {
    adminScreen = index;
    emit(ChangeDonorHomeScreensState());
  }

  void changeBloodTypeForAddPatient(bloodType) {
    bloodTypeForAddPatient = bloodType;
    emit(ChangeBloodTypeAddPatientState());
  }

  void changeSelectedItemForAddPatient(index) {
    selectedIndexAddPatient = index;
    emit(ChangeSelectedItemAddPatientState());
  }

  void changeSelectedGenderForAddPatient(value) {
    selectedGenderAddPatient = value;

    if (value == Gender.female) selectedGenderAddPatientAsString = 'female';
    if (value == Gender.male) selectedGenderAddPatientAsString = 'male';
    emit(ChangeSelectedGenderForAddPatientState());
  }

  void changeSelectedHospitalForAddPatient(value) {
    selectedHospitalAddPatient = value;
    if (value == Hospital.PrinceHamzahHospital)
      selectedHospitalAddPatientAsString = 'Prince Hamzah Hospital';
    if (value == Hospital.UniversityofJordanHospital)
      selectedHospitalAddPatientAsString = 'University of Jordan Hospital';
    if (value == Hospital.AlBashirHospital)
      selectedHospitalAddPatientAsString = 'Al-Bashir Hospital';
    emit(ChangeSelectedHospitalForAddPatientState());
  }

  void changeSelectedItemForDonors(index) {
    selectedIndexDonors = index;
    emit(ChangeSelectedItemDonorsState());
  }

  void changeBloodTypeListForDonors(index) {
    bloodTypeListForDonors = index;
    emit(ChangeBloodTypeListDonorsState());
  }

  void changeIconInPatientList() {
    if (iconInPatientList == Icons.arrow_downward) {
      iconInPatientList = Icons.arrow_upward;
    } else {
      iconInPatientList = Icons.arrow_downward;
    }

    emit(ChangeIconInPatientListState());
  }

  bool isChecked = false;

  void changeIsCheckedBox() {
    isChecked = !isChecked;
    emit(ChangeIsCheckedBoxState());
  }

  void changeSelectedItemForSignUp(index) {
    selectedIndexSignUp = index;
    emit(ChangeSelectedItemForSignUpState());
  }

  Future<void> pushNotification({required bloodType}) async {
    var body = {
      "message": {
        "topic": "$bloodType",
        "notification": {
          "title": "Blood Donation",
          "body": "An emergency donation compatible with your blood type"
        },
      }
    };
    getAccessToken().then((value) {
      var headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $value'
      };
      print(value);
      post(
              Uri.parse(
                  'https://fcm.googleapis.com/v1/projects/blood-donation-11584/messages:send'),
              body: json.encode(body),
              encoding: Encoding.getByName('utf-8'),
              headers: headers)
          .then((value) {
        emit(PushNotificationState());
      })
          .catchError((error) {
        print(error.toString());
      });
    });
  }

  Future<String> getAccessToken() async {
    final String response =
        await rootBundle.loadString('assets/service-account.json');
    final data = await json.decode(response);
    final credentials = ServiceAccountCredentials.fromJson(data);

    final client = await clientViaServiceAccount(
      credentials,
      [
        'https://www.googleapis.com/auth/firebase.messaging'
      ], // Replace with your desired scopes
    );

    final accessToken = await client.credentials.accessToken;
    return accessToken.data;
  }

  void donationMade({required patientId,required donorId})
  {
    DioHelper.putToDatabase(url: 'Patient/Donor/$patientId/Donor/$donorId').then((value) {
      emit(DonationMadeState());
    }).catchError((error){
      emit(FailedDonationMadeState());
    });
  }
  void deleteDonorToPatient({required patientId,required donorId})
  {
    DioHelper.deleteFromDatabase(url: 'Patient/Donor/$patientId/Donor/$donorId').then((value) {
      emit(DeleteDonorToPatientState());
    }).catchError((error){
      emit(FailedDeleteDonorToPatientState());
    });
  }

  void saveDonationMadeForPatientId(id,name)
  {
    donationMadeForPatientId = id;
    donationMadeForPatientName = name;
    emit(SaveDonationMadeForPatientIdState());
  }
}
