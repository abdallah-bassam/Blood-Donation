import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';

import '../models/patient_model.dart';

Widget listOfAllPatients() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: patientModels[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: patientModels.length,
);

Widget listOfAPlusPatients() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: patientModelsAPlus[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: patientModelsAPlus.length,
);

Widget listOfBPlusPatients() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: patientModelsBPlus[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: patientModelsBPlus.length,
);

Widget listOfPatientsInAHospital() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildPatientItem(
      context: context, patientModel: patientModelsAHospital[index]),
  separatorBuilder: (context, index) => SizedBox(height: 10,),
  itemCount: patientModelsAHospital.length,
);