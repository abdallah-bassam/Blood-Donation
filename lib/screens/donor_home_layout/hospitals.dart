import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/reusable_components.dart';

class Hospitals extends StatelessWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BlocProvider.of(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sharedText(
                  text: "Save a life", fontSize: 20, color: Color(0xFFB6B6B6)),
              SizedBox(
                height: 3,
              ),
              sharedText(
                  text: 'Here contains all the hospitals',
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 15
              ),

              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.local_hospital,color: Colors.white,),
                      SizedBox(width: 4,),
                      sharedText(text: 'Al-Bashir Hospital',fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),
                      Spacer(),
                      IconButton(icon: Icon(cubit.iconInHospitalAList,size: 35),color: Colors.white,onPressed: (){
                        cubit.changeIconInHospitalAList();
                        cubit.addToInnerListForHospitalA(context);
                        cubit.changeShowInnerListForHospitalA();
                      },)
                    ],
                  ),
                  onTap: () {
                    cubit.changeIconInHospitalAList();
                    cubit.addToInnerListForHospitalA(context);
                    cubit.changeShowInnerListForHospitalA();
                  },
                ),
              ),
              if (cubit.showInnerListForHospitalA)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cubit.innerListForHospitalA!
                      .map((innerItem) => Container(
                    width: MediaQuery.of(context).size.width,
                        child: ListTile(
                              title: innerItem,
                            ),
                      ))
                      .toList(),
                ),

              SizedBox(
                  height: 15
              ),

              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.local_hospital,color: Colors.white,),
                      SizedBox(width: 4,),
                      sharedText(text: 'Prince Hamzah Hospital',fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),
                      Spacer(),
                      IconButton(icon: Icon(cubit.iconInHospitalBList,size: 35),color: Colors.white,onPressed: (){
                        cubit.changeIconInHospitalBList();
                        cubit.addToInnerListForHospitalB(context);
                        cubit.changeShowInnerListForHospitalB();
                      },)
                    ],
                  ),
                  onTap: () {
                    cubit.changeIconInHospitalBList();
                    cubit.addToInnerListForHospitalB(context);
                    cubit.changeShowInnerListForHospitalB();
                  },
                ),
              ),
              if (cubit.showInnerListForHospitalB)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cubit.innerListForHospitalB!
                      .map((innerItem) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      title: innerItem,
                    ),
                  ))
                      .toList(),
                ),

              SizedBox(
                  height: 15
              ),

              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.local_hospital,color: Colors.white,),
                      SizedBox(width: 4,),
                      sharedText(text: 'University of Jordan',fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),
                      Spacer(),
                      IconButton(icon: Icon(cubit.iconInHospitalCList,size: 35),color: Colors.white,onPressed: (){
                        cubit.changeIconInHospitalCList();
                        cubit.addToInnerListForHospitalC(context);
                        cubit.changeShowInnerListForHospitalC();
                      },)
                    ],
                  ),
                  onTap: () {
                    cubit.changeIconInHospitalCList();
                    cubit.addToInnerListForHospitalC(context);
                    cubit.changeShowInnerListForHospitalC();
                  },
                ),
              ),
              if (cubit.showInnerListForHospitalC)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cubit.innerListForHospitalC!
                      .map((innerItem) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      title: innerItem,
                    ),
                  ))
                      .toList(),
                ),

            ],
          ),
        );
      },
    );
  }
}
