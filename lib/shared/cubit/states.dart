
abstract class BloodDonationStates{}

class InitialAppState extends BloodDonationStates{}
class ChangePasswordIconState extends BloodDonationStates{}
class ChangeIsPasswordState extends BloodDonationStates{}
class ChangeRememberMeIconState extends BloodDonationStates{}
class SuccessUserLoginState extends BloodDonationStates{}
class FailedUserLoginState extends BloodDonationStates{
  String error;
  FailedUserLoginState({required this.error});
}
class LoadingLoginState extends BloodDonationStates{}
class SuccessDonorSignUpState extends BloodDonationStates{}
class FailedDonorSignUpState extends BloodDonationStates{
  String error;
  FailedDonorSignUpState({required this.error});

}
class LoadingSignUpState extends BloodDonationStates{}
class ChangeIndexOfBottomNavBarDonorState extends BloodDonationStates{}
class ChangeDonorHomeScreensState extends BloodDonationStates{}
class ChangeSelectedItemState extends BloodDonationStates{}
class ChangeBloodTypeListState extends BloodDonationStates{}
class ChangeLengthOfListState extends BloodDonationStates{}
class ChangeShowInnerListHospitalAState extends BloodDonationStates{}
class ChangeIconInHospitalAListState extends BloodDonationStates{}
class AddToInnerListForHospitalAState extends BloodDonationStates{}

class ChangeShowInnerListHospitalBState extends BloodDonationStates{}
class ChangeIconInHospitalBListState extends BloodDonationStates{}
class AddToInnerListForHospitalBState extends BloodDonationStates{}

class ChangeConfirmPasswordIconState extends BloodDonationStates{}
class ChangeIsConfirmPasswordState extends BloodDonationStates{}
class ChangeSelectedGenderState extends BloodDonationStates{}

class SuccessGetAllPatientsState extends BloodDonationStates{}
class FailedGetAllPatientsState extends BloodDonationStates{}
class SuccessGetAllDonorsState extends BloodDonationStates{}
class FailedGetAllDonorsState extends BloodDonationStates{}
class SuccessGetDonorsForPatientState extends BloodDonationStates{}
class FailedGetDonorsForPatientState extends BloodDonationStates{}
class SuccessAddPatientState extends BloodDonationStates{}
class FailedAddPatientState extends BloodDonationStates{}
class SuccessPostDonorToPatient extends BloodDonationStates{}
class FailedPostDonorToPatient extends BloodDonationStates{}
// Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin Admin

class ChangeIndexOfBottomNavBarAdminState extends BloodDonationStates{}
class ChangeAdminHomeScreensState extends BloodDonationStates{}
class ChangeBloodTypeAddPatientState extends BloodDonationStates{}
class ChangeSelectedItemAddPatientState extends BloodDonationStates{}
class ChangeSelectedGenderForAddPatientState extends BloodDonationStates{}
class ChangeSelectedHospitalForAddPatientState extends BloodDonationStates{}
class ChangeSelectedItemDonorsState extends BloodDonationStates{}
class ChangeBloodTypeListDonorsState extends BloodDonationStates{}
class ChangeIconInPatientListState extends BloodDonationStates{}
class ChangeIsCheckedBoxState extends BloodDonationStates{}
class ChangeSelectedItemForSignUpState extends BloodDonationStates{}
class PushNotificationState extends BloodDonationStates{}
class ChangeSearchedPatientNotFoundState extends BloodDonationStates{}