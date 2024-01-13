import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/reusable_components.dart';

class AddPatients extends StatelessWidget {
  AddPatients({Key? key}) : super(key: key);

  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  var formKey = GlobalKey<FormState>();
  RegExp ageRegex = RegExp(r'^\d{1,3}$');
  RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sharedText(
                      text: "Add Patient",
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  sharedText(
                      text: "with all the details about him",
                      fontSize: 20,
                      color: Color(0xFFB6B6B6)),
                  SizedBox(
                    height: 20,
                  ),
                  sharedTextFormField(
                      controller: cubit.firstNamePatientController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        if (!nameRegex.hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      isPassword: false,
                      label: 'First Name'),
                  SizedBox(
                    height: 10,
                  ),
                  sharedTextFormField(
                      controller: cubit.lastNamePatientController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        if (!nameRegex.hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      isPassword: false,
                      label: 'last Name'),
                  SizedBox(
                    height: 10,
                  ),
                  sharedTextFormField(
                      controller: cubit.agePatientController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (!ageRegex.hasMatch(value)) {
                          return 'Invalid age format';
                        }
                        return null;
                      },
                      label: 'Age',
                      suffix: null,
                      isPassword: false,
                      width: 70,
                      textInputType: TextInputType.number),
                  SizedBox(
                    height: 10,
                  ),
                  sharedText(text: 'Select blood type', fontSize: 20),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          bloodTypesBoxForAddPatient(
                              bloodType: bloodTypes[index],
                              context: context,
                              index: index),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                      itemCount: bloodTypes.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  sharedText(text: 'Select Gender', fontSize: 20),
                  buildGenderForAddPatient(
                      context: context,
                      gender: Gender.male,
                      textGender: 'Male'),
                  buildGenderForAddPatient(
                      context: context,
                      gender: Gender.female,
                      textGender: 'Female'),
                  SizedBox(
                    height: 10,
                  ),
                  sharedText(text: 'Select Hospital', fontSize: 20),
                  Container(
                    height: 55 * Hospital.values.length.toDouble(),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildHospitalForAddPatient(
                                context: context,
                                hospital: Hospital.values[index],
                                textHospital: hospitalsForAddPatients[index]),
                        separatorBuilder: (context, index) => SizedBox(height: 1,),
                        itemCount: Hospital.values.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                        controller: BloodDonationCubit.get(context)
                            .firstDateToDonateController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "date must not be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'First date to donate',
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-12-12'));
                          BloodDonationCubit.get(context)
                              .firstDateToDonateController
                              .text = DateFormat.yMMMd().format(date!);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                        controller: BloodDonationCubit.get(context)
                            .lastDateToDonateController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "date must not be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Last date to donate',
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-12-12'));
                          BloodDonationCubit.get(context)
                              .lastDateToDonateController
                              .text = DateFormat.yMMMd().format(date!);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: sharedMaterialButtonAccount(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          cubit.selectedIndexAddPatient != -1 &&
                          cubit.selectedGenderAddPatient != null &&
                          cubit.firstDateToDonateController.text.isNotEmpty &&
                          cubit.lastDateToDonateController.text.isNotEmpty) {


                        cubit.addPatient(
                            firstDate: cubit.firstDateToDonateController.text,
                            lastDate: cubit.lastDateToDonateController.text,
                            firstName: cubit.firstNamePatientController.text,
                            lastName: cubit.lastNamePatientController.text,
                            nameHospital: cubit.selectedHospitalAddPatientAsString,
                            age:
                                int.tryParse(cubit.agePatientController.text) ??
                                    0,
                            gender: cubit.selectedGenderAddPatientAsString,
                            bloodType: cubit.bloodTypeForAddPatient);


                        String bloodType = '';
                        if (cubit.bloodTypeForAddPatient == 'A+') {
                          bloodType = 'APlus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A-') {
                          bloodType = 'AMinus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A+') {
                          bloodType = 'BPlus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A-') {
                          bloodType = 'BMinus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A+') {
                          bloodType = 'ABPlus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A-') {
                          bloodType = 'ABMinus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A+') {
                          bloodType = 'OPlus';
                        }
                        if (cubit.bloodTypeForAddPatient == 'A-') {
                          bloodType = 'OMinus';
                        }
                        cubit
                            .pushNotification(bloodType: bloodType)
                            .then((value) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: null,
                                content: sharedText(
                                    text: 'Added Successfully',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }).catchError((error) {
                          print(error.toString());
                        });
                      }
                    },
                    text: 'Add',
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
