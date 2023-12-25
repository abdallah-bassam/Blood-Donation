import 'package:blood_donation/models/donor_model.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/cupertino.dart';

Widget listOfAllDonors() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: donorModels[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: donorModels.length,
);

Widget listOfAPlusDonors() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: donorModelsAPlus[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: donorModelsAPlus.length,
);

Widget listOfBPlusDonors() => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: donorModelsBPlus[index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: donorModelsBPlus.length,
);