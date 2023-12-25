import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/reusable_components.dart';

class DonorHome extends StatelessWidget {
  DonorHome({Key? key}) : super(key: key);
  String name = "#name";
  List<NotesModel> notes = [
    NotesModel(image: 'assets/images/home1.jpg', title: "Donate Blood", body: 'Donate blood at your own free time at any hospital or blood bank near you'),
    NotesModel(image: 'assets/images/home2.jpg', title: "Schedule Appointment", body: 'Easily schedule appointments to help save a life'),
  ];
  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BlocProvider.of(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sharedText(text: "Hello, let's donate", fontSize: 20,color: Color(0xFFB6B6B6)),
              SizedBox(height: 3,),
              sharedText(text: name, fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
              SizedBox(height: 25,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 250,
                    child: PageView.builder(
                      controller: boardController,
                      itemBuilder: (context, index) => buildNotesItem(notes[index]),
                      itemCount: notes.length,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: boardController,
                    count: notes.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.red,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Column(
                children: [
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeDonorHomeScreens(1);
                  }, text: 'Donate', context: context,icon: Icons.bloodtype),
                  SizedBox(height: 25,),
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeDonorHomeScreens(2);
                  }, text: 'Hospitals', context: context,icon: Icons.local_hospital),
                  SizedBox(height: 25,),
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeDonorHomeScreens(3);
                    cubit.changeIndexOfBottomNavBarDonor(1);
                  }, text: 'Notifications', context: context,icon: Icons.notifications),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildNotesItem(NotesModel model) =>
      ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(image: AssetImage(model.image), fit: BoxFit.fitWidth)
      );
}


class NotesModel {
  String image;
  String title;
  String body;

  NotesModel({required this.image, required this.title, required this.body});
}