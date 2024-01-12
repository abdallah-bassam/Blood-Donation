import 'package:blood_donation/models/donor_model.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/cupertino.dart';

Widget listOfAllDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModels![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModels!.length,
);

Widget listOfAPlusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsAPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsAPlus!.length,
);

Widget listOfAMinusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsAMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsAMinus!.length,
);

Widget listOfBPlusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsBPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsBPlus!.length,
);

Widget listOfBMinusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsBMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsBMinus!.length,
);

Widget listOfABPlusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsABPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsABPlus!.length,
);

Widget listOfABMinusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsABMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsABMinus!.length,
);

Widget listOfOPlusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsOPlus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsOPlus!.length,
);

Widget listOfOMinusDonors(context) => ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildDonorItem(
      context: context, donorModel: BloodDonationCubit.get(context).donorModelsOMinus![index]),
  separatorBuilder: (context, index) => SizedBox(
    height: 10,
  ),
  itemCount: BloodDonationCubit.get(context).donorModelsOMinus!.length,
);