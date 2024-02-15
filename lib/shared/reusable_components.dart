import 'package:alert_dialog/alert_dialog.dart';
import 'package:blood_donation/screens/admin_home_layout/patients/donors_of_patient.dart';
import 'package:blood_donation/screens/donor_home_layout/donor_home.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget sharedText(
        {required String text,
        required double? fontSize,
        Color? color,
        FontWeight? fontWeight}) =>
    Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'Manrope',
          fontWeight: fontWeight),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );

Widget sharedTextFormField({
  required TextEditingController controller,
  required FormFieldValidator validator,
  String? label,
  String? hintText,
  IconData? suffix,
  VoidCallback? onPressedSuffix,
  TextInputType? textInputType,
  double width = 0,
  required bool isPassword,
}) =>
    Container(
      width: width == 0 ? 335 : width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        keyboardType: textInputType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFFB6B6B6), width: 2), // Customize the color here
          ),
          label: label==null?null:Text(label!),
          hintText: hintText,
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                  ),
                  onPressed: onPressedSuffix,
                )
              : null,
        ),
      ),
    );

Widget sharedMaterialButtonAccount({
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      height: 60,
      width: 275,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: sharedText(text: text, fontSize: 18, color: Colors.white),
      ),
    );

Widget sharedMaterialButtonApp(
        {required VoidCallback onPressed,
        required String text,
        required BuildContext context,
        IconData? icon,
        double width = 0}) =>
    Container(
      height: 75,
      width: width == 0 ? MediaQuery.of(context).size.width * 0.9 : width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: sharedText(
                    text: text,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              //    Spacer(),
              Icon(
                icon,
                color: Colors.red,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );

Widget sharedSearchBox({
  required BuildContext context,
}) =>
    Row(
      children: [
        Expanded(
          child: TextFormField(
            controller:
                BloodDonationCubit.get(context).searchPatientsForAdminContoller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFFB6B6B6),
                      width: 2), // Customize the color here
                ),
                label: sharedText(text: 'Search by name..', fontSize: 18),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.only(left: 1),
          onPressed: () {
            BloodDonationCubit.get(context).getPatientsBySearch(
                firstName: BloodDonationCubit.get(context)
                    .searchPatientsForAdminContoller
                    .text);
          },
          child: Container(
            height: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child:
                sharedText(text: 'Search', fontSize: 20, color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: () {
            BloodDonationCubit.get(context).changeSearchedPatientNotFound();
          },
          child: Container(
            height: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: sharedText(text: 'All', fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );

Widget bloodTypesBoxForDonate(
    {required String bloodType,
    required BuildContext context,
    required int index}) {
  return GestureDetector(
    onTap: () {
      BloodDonationCubit.get(context).changeSelectedItemForDonate(index);
      BloodDonationCubit.get(context).changeBloodTypeListForDonate(index);
      BloodDonationCubit.get(context)
          .getPatientsByBloodType(bloodType: bloodType);
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BloodDonationCubit.get(context).selectedIndex == index
            ? Colors.red
            : Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined,
              color: BloodDonationCubit.get(context).selectedIndex == index
                  ? Colors.white
                  : Colors.black),
          SizedBox(
            width: 4,
          ),
          sharedText(
            text: bloodType,
            fontSize: 20,
            color: BloodDonationCubit.get(context).selectedIndex == index
                ? Colors.white
                : Colors.black,
          )
        ],
      ),
    ),
  );
}

Widget bloodTypesBoxForAddPatient(
    {required String bloodType,
    required BuildContext context,
    required int index}) {
  return GestureDetector(
    //behavior: HitTestBehavior.translucent, // Add this line
    onTap: () {
      BloodDonationCubit.get(context).changeSelectedItemForAddPatient(index);
      BloodDonationCubit.get(context).changeBloodTypeForAddPatient(bloodType);
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BloodDonationCubit.get(context).selectedIndexAddPatient == index
            ? Colors.red
            : Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined,
              color: BloodDonationCubit.get(context).selectedIndexAddPatient ==
                      index
                  ? Colors.white
                  : Colors.black),
          SizedBox(
            width: 4,
          ),
          sharedText(
            text: bloodType,
            fontSize: 20,
            color:
                BloodDonationCubit.get(context).selectedIndexAddPatient == index
                    ? Colors.white
                    : Colors.black,
          )
        ],
      ),
    ),
  );
}

Widget buildPatientItem(
        {required BuildContext context, required patientModel}) =>
    Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['first_Name'] +
                            ' ' +
                            patientModel['last_Name'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.bloodtype),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['blood_Type'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['name_Hospital'].toString(),
                        fontSize: 20),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () async {
                    return alert(
                      context,
                      title: sharedText(
                          text: 'Donate for ${patientModel['first_Name']}',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      content: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: sharedText(
                                      text:
                                          'Donation is available from ${patientModel['first_Date']} to ${patientModel['last_Date']}',
                                      fontSize: 18)),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: sharedText(
                                    text:
                                        'Hospital working hours From 8:00 to 3:00',
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_pin),
                              SizedBox(
                                width: 5,
                              ),
                              sharedText(
                                  text: patientModel['name_Hospital'],
                                  fontSize: 18),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          sharedText(
                              text:
                                  'Please enter the time and date you want to donate',
                              fontSize: 18),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: BloodDonationCubit.get(context)
                                  .dateDonateController,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "date must not be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Date',
                                prefixIcon: Icon(Icons.date_range),
                              ),
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-12-12'));
                                BloodDonationCubit.get(context)
                                    .dateDonateController
                                    .text = DateFormat.yMMMd().format(date!);
                              }),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: BloodDonationCubit.get(context)
                                  .timeDonateController,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "date must not be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Time',
                                prefixIcon: Icon(Icons.watch_later),
                              ),
                              onTap: () async {
                                var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                BloodDonationCubit.get(context)
                                    .timeDonateController
                                    .text = time!.format(context).toString();
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          sharedText(
                              text: 'Important conditions to donate:',
                              fontSize: 20,
                              color: Colors.red),
                          SizedBox(
                            height: 8,
                          ),
                          sharedText(
                              text:
                                  '1-Must be a holder of Jordanian citizenship',
                              fontSize: 18),
                          SizedBox(
                            height: 8,
                          ),
                          sharedText(
                              text:
                                  '2-When donating, you must have your personal ID with you',
                              fontSize: 18),
                        ],
                      ),
                      textOK: Center(
                        child: MaterialButton(
                          onPressed: () {
                            BloodDonationCubit.get(context).postDonorToPatient(
                                donorId: userDonor['donor_id'],
                                patientId: patientModel['patient_Id']);
                            BloodDonationCubit.get(context).getPatientsForDonor(
                                patientModel['patient_Id']);
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: null,
                                    content: sharedText(
                                        text:
                                            'Thank you, we are waiting for you to donate',
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
                                });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.all(10),
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            child: sharedText(
                                text: 'Done',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    child: sharedText(
                        text: 'Donate', fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildHistoryOfDonations(
        {required BuildContext context, required patientModel}) =>
    Container(
      height: 230,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['first_Name'] +
                            ' ' +
                            patientModel['last_Name'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.bloodtype),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['blood_Type'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['name_Hospital'].toString(),
                        fontSize: 20),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['first_Date'].toString(),
                        fontSize: 20),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['last_Date'].toString(),
                        fontSize: 20),
                  ],
                ),
                SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        BloodDonationCubit.get(context).deletePatientFromDonor(patientModel);
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: sharedText(
                            text: 'Done',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildGenderForAddPatient(
        {required Gender gender,
        required String textGender,
        required BuildContext context}) =>
    RadioListTile<Gender>(
      title: sharedText(text: textGender, fontSize: 18),
      value: gender,
      groupValue: BloodDonationCubit.get(context).selectedGenderAddPatient,
      onChanged: (value) {
        BloodDonationCubit.get(context)
            .changeSelectedGenderForAddPatient(value);
      },
    );

Widget buildHospitalForAddPatient(
        {required Hospital hospital,
        required String textHospital,
        required BuildContext context}) =>
    RadioListTile<Hospital>(
      title: sharedText(text: textHospital, fontSize: 18),
      value: hospital,
      groupValue: BloodDonationCubit.get(context).selectedHospitalAddPatient,
      onChanged: (value) {
        BloodDonationCubit.get(context)
            .changeSelectedHospitalForAddPatient(value);
      },
    );

Widget buildDonorItem({required BuildContext context, required donorModel}) =>
    Container(
      height: 190,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['first_Name'] +
                            ' ' +
                            donorModel['last_Name'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.bloodtype,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['blood_Type'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    donorModel['gender'] == 'male'
                        ? Icon(Icons.male)
                        : Icon(Icons.female),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(text: donorModel['gender'], fontSize: 20),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    sharedText(text: 'Age:', fontSize: 20),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['age'].toString(), fontSize: 20),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.numbers),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['phone'].toString(), fontSize: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildDonorsOfPatient(
        {required BuildContext context, required donorModel}) =>
    Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['first_Name'] +
                            ' ' +
                            donorModel['last_Name'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.bloodtype),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['blood_Type'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: donorModel['phone'].toString(), fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: (){
                        BloodDonationCubit.get(context).donationMade(patientId: BloodDonationCubit.get(context).donationMadeForPatientId, donorId: donorModel['donor_id']);
                        BloodDonationCubit.get(context).deleteDonorToPatient(patientId: BloodDonationCubit.get(context).donationMadeForPatientId,donorId: donorModel['donor_id']);
                        BloodDonationCubit.get(context)
                            .getDonorsForPatient(
                            patientId: BloodDonationCubit.get(context).donationMadeForPatientId);
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        width: 165,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: sharedText(
                            text: 'Donation made',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget bloodTypesBoxForDonors(
    {required BuildContext context,
    required String bloodType,
    required int index}) {
  return GestureDetector(
    //behavior: HitTestBehavior.translucent, // Add this line
    onTap: () {
      BloodDonationCubit.get(context).changeSelectedItemForDonors(index);
      BloodDonationCubit.get(context).changeBloodTypeListForDonors(index);
      BloodDonationCubit.get(context)
          .getDonorsByBloodType(bloodType: bloodType);
      print(BloodDonationCubit.get(context).bloodTypeListForDonors);
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BloodDonationCubit.get(context).selectedIndexDonors == index
            ? Colors.red
            : Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined,
              color:
                  BloodDonationCubit.get(context).selectedIndexDonors == index
                      ? Colors.white
                      : Colors.black),
          SizedBox(
            width: 4,
          ),
          sharedText(
            text: bloodType,
            fontSize: 20,
            color: BloodDonationCubit.get(context).selectedIndexDonors == index
                ? Colors.white
                : Colors.black,
          )
        ],
      ),
    ),
  );
}

Widget buildPatientItemForAdmin({
  required BuildContext context,
  required patientModel,
}) =>
    Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['first_Name'] +
                            ' ' +
                            patientModel['last_Name'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(Icons.bloodtype),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['blood_Type'],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 5,
                    ),
                    sharedText(
                        text: patientModel['name_Hospital'], fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        await BloodDonationCubit.get(context)
                            .getDonorsForPatient(
                                patientId: patientModel['patient_Id']);
                        BloodDonationCubit.get(context).saveDonationMadeForPatientId(patientModel['patient_Id'],patientModel['first_Name'] + ' ' + patientModel['last_Name']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DonorsOfPatient(),
                            ));
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: sharedText(
                            text: 'Show donors',
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget bloodTypesBoxForSignUp(
    {required BuildContext context,
    required String bloodType,
    required int index}) {
  return GestureDetector(
    //behavior: HitTestBehavior.translucent, // Add this line
    onTap: () {
      BloodDonationCubit.get(context).changeSelectedItemForSignUp(index);
    },
    child: Container(
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BloodDonationCubit.get(context).selectedIndexSignUp == index
            ? Colors.red
            : Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bloodtype_outlined,
              color:
                  BloodDonationCubit.get(context).selectedIndexSignUp == index
                      ? Colors.white
                      : Colors.black),
          SizedBox(
            width: 4,
          ),
          sharedText(
            text: bloodType,
            fontSize: 20,
            color: BloodDonationCubit.get(context).selectedIndexSignUp == index
                ? Colors.white
                : Colors.black,
          )
        ],
      ),
    ),
  );
}
