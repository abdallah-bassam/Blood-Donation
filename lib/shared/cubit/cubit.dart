import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/models/patient_model.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import '../reusable_components.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;

enum Gender { male, female }

enum Hospital { Albasheer, alameerhamza, university }

List<String> hospitalsForAddPatients = [
  'Albasheer',
  'alameer hamza',
  'university'
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

  int currentIndexDonor = 0;
  int screen = 0;
  int selectedIndex = 0;
  TextEditingController dateDonateController = TextEditingController();
  TextEditingController timeDonateController = TextEditingController();
  int bloodTypeListForPatients = 0;
  int lengthOfList = patientModels.length;

  bool showInnerListForHospitalA = false;
  List<Widget> innerListForHospitalA = [];
  IconData iconInHospitalAList = Icons.arrow_circle_down_rounded;

  void userLogin({required String email, required String password}) {
    emit(LoadingLoginState());

    DioHelper.postToDatabase(
        url: '', data: {'email': email, 'password': password}).then((value) {
      emit(SuccessUserLoginState());
    }).catchError((error) {
      emit(FailedUserLoginState(error: error.toString()));
    });
  }

  void donorSignUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String age,
      required String gender,
      required String bloodType}) {
    emit(LoadingSignUpState());
    DioHelper.postToDatabase(url: '', data: {
      "email": email,
      "password": password,
      "first name": firstName,
      "last name": lastName,
      "phone number": phoneNumber,
      "age": age,
      "gender": gender,
      "blood type": bloodType
    }).then((value){
      emit(SuccessDonorSignUpState());
    }).catchError((error){
      emit(FailedDonorSignUpState(error: error.toString()));
    });

  }

  void changeIconInHospitalAList() {
    if (iconInHospitalAList == Icons.arrow_circle_down_rounded) {
      iconInHospitalAList = Icons.arrow_circle_up_rounded;
    } else {
      iconInHospitalAList = Icons.arrow_circle_down_rounded;
    }
    emit(ChangeIconInHospitalAListState());
  }

  void addToInnerListForHospitalA(BuildContext context) {
    innerListForHospitalA = [];
    for (int index = 0; index < patientModelsAHospital.length; index++) {
      innerListForHospitalA.add(buildPatientItem(
        context: context,
        patientModel: patientModelsAHospital[index],
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

  void addToInnerListForHospitalB(BuildContext context) {
    innerListForHospitalB = [];
    for (int index = 0; index < patientModelsBHospital.length; index++) {
      innerListForHospitalB.add(buildPatientItem(
        context: context,
        patientModel: patientModelsBHospital[index],
      ));
    }

    emit(AddToInnerListForHospitalBState());
  }

  void changeShowInnerListForHospitalB() {
    showInnerListForHospitalB = !showInnerListForHospitalB;
    emit(ChangeShowInnerListHospitalBState());
  }

  void changeLengthOfList(index) {
    lengthOfList = index;
    emit(ChangeLengthOfListState());
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
    emit(ChangeSelectedGenderForAddPatientState());
  }

  void changeSelectedHospitalForAddPatient(value) {
    selectedHospitalAddPatient = value;
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
      post(
              Uri.parse(
                  'https://fcm.googleapis.com/v1/projects/blood-donation-11584/messages:send'),
              body: json.encode(body),
              encoding: Encoding.getByName('utf-8'),
              headers: headers)
          .then((value) {})
          .catchError((error) {
        print(error.toString());
      });
      emit(PushNotificationState());
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
}
