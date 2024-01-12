import '../shared/cubit/cubit.dart';

class PatientModel{
  String name;
  String bloodType;
  String hospitalName;

  PatientModel({required this.name, required this.bloodType, required this.hospitalName});
}

// List <PatientModel> patientModels = [
//   PatientModel(name: 'Ahmad Khaled',bloodType: 'A+',hospitalName: 'A'),
//   PatientModel(name: 'Omar Hasan',bloodType: 'B+',hospitalName: 'A'),
//   PatientModel(name: 'Aysar  Mohammad',bloodType: 'A+',hospitalName: 'B'),
//   PatientModel(name: 'Mohammad Ahmad',bloodType: 'AB+',hospitalName: 'A'),
//   PatientModel(name: 'Abdallah Yasin',bloodType: 'O+',hospitalName: 'C'),
//   PatientModel(name: 'Khaled Ahmad',bloodType: 'O+',hospitalName: 'C'),
//   PatientModel(name: 'abdulrahman hasan',bloodType: 'O-',hospitalName: 'B'),
//   PatientModel(name: 'Hamza omar',bloodType: 'B-',hospitalName: 'A'),
//   PatientModel(name: 'Ahmad Abdallah',bloodType: 'AB-',hospitalName: 'B'),
//   PatientModel(name: 'Husam Ali',bloodType: 'A-',hospitalName: 'B'),
// ];



List <Map<String,String>> patientModelsAPlus = [
  {
'name': 'Ahmad Khaled','bloodType': 'A+','hospitalName': 'A'
},

{ 'name': 'Aysar  Mohammad', 'bloodType': 'A+', 'hospitalName': 'B',},

];

List <Map<String,String>> patientModelsBPlus = [
  {
    'name': 'Omar Hasan','bloodType': 'B+','hospitalName': 'A'
  },

];

List <Map<String,String>> patientModelsAHospital = [
  {
    'name': 'Ahmad Khaled','bloodType': 'A+','hospitalName': 'A'
  },
  {
    'name': 'Omar Hasan','bloodType': 'B+','hospitalName': 'A'
  },
  { 'name': 'Hamza omar', 'bloodType': 'B-', 'hospitalName': 'A',},
  { 'name': 'Mohammad Ahmad', 'bloodType': 'AB+', 'hospitalName': 'A',},
];
List <Map<String,String>> patientModelsBHospital = [
  { 'name': 'Aysar  Mohammad', 'bloodType': 'A+', 'hospitalName': 'B',},
  { 'name': 'Ahmad Abdallah', 'bloodType': 'AB-', 'hospitalName': 'B',},
  { 'name': 'Husam Ali', 'bloodType': 'A-', 'hospitalName': 'B',},
  { 'name': 'abdulrahman hasan', 'bloodType': 'O-', 'hospitalName': 'B',},
];
List <Map<String,String>> patientModelsCHospital = [
  { 'name': 'Abdallah Yasin', 'bloodType': 'O+', 'hospitalName': 'C',},
  { 'name': 'Khaled Ahmad', 'bloodType': 'O+', 'hospitalName': 'C',},
];