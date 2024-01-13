import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';

import '../models/patient_model.dart';
import 'cubit/cubit.dart';

Widget listOfSearchedPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).searchedPatientModels![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).searchedPatientModels!.length,
);

Widget listOfAllPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModels![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModels!.length,
);

Widget listOfAPlusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsAPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsAPlus!.length,
);

Widget listOfAMinusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsAMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsAMinus!.length,
);

Widget listOfBPlusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsBPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsBPlus!.length,
);

Widget listOfBMinusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsBMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsBMinus!.length,
);

Widget listOfABPlusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsABPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsABPlus!.length,
);

Widget listOfABMinusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsABMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsABMinus!.length,
);

Widget listOfOPlusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsOPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsOPlus!.length,
);


Widget listOfOMinusPatients(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsOMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsOMinus!.length,
);

Widget listOfPatientsForNotifications(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: BloodDonationCubit.get(context).patientModelsForNotifications![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).patientModelsForNotifications!.length,
);