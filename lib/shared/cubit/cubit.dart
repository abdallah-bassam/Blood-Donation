import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/models/patient_model.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screens/sign_up.dart';
import '../reusable_components.dart';
import 'package:http/http.dart';

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

  void userLogin({
    required String email,
    required String password,
  }) {
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(SuccessUserLoginState());
    }).catchError((e) {
      print(e.toString());
      emit(FailedUserLoginState());
    });
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
  int selectedIndexAddPatient = 0;
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
      "to": "topics/$bloodType",
      "notification": {
        "title": "Blood Donation",
        "body": "An emergency donation compatible with your blood type"
      },
      // "android":{
      //   "priority":"HIGH",
      //   "notification":{
      //     "notification_priority":"PRIORITY_MAX",
      //     "sound":"default",
      //     "default_sound":true,
      //     "default_vibrate_timings":true,
      //     "default_light_settings":true
      //   }
      // },
      "data": {
        "type": "order",
        "id": '28',
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    };
    var headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAbULXVGg:APA91bFcYGhk3aIZDa6rIYiSAdqcWnTatcgPaXHK5SqVuTrXxTh1ArNBWM4rn6ZD9LLA_GelnaD7_rcjJ05u4Q5JFYNqTuNAdhBvZK2U81h5rRFgPzSANY28Gt_4NMvP-in8aYwwWxcn'
    };
    var response = await post(Uri.parse('http://fcm.googleapis.com/fcm/send'),
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
        headers: headers
        ).then((value) {}).catchError((error) {
      print(error.toString());
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    emit(PushNotificationState());
  }
}
