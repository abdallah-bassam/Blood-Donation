import 'package:blood_donation/screens/starting_app/sign_up.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login.dart';

class BoardingModel {
  String image;
  String title;
  String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/new-test1.jpg',
        title: ""
            "Never run out of blood",
        body: 'One part of blood cane save up to three lives'),
    BoardingModel(image: 'assets/images/test.jpg', title: "Donate Blood", body: 'Donate blood at your own free time at any hospital or blood bank near you'),
    BoardingModel(image: 'assets/images/new-test2.jpg', title: "Schedule Appointment", body: 'Easily schedule appointments to help save a life'),
  ];
  var boardController = PageController();
  bool isLast = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }, child: sharedText(text: 'SKIP', fontSize: 20, fontWeight: FontWeight.w500)),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.red,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(

                  onPressed: () {
                    if (isLast) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child:
                  Image(image: AssetImage(model.image), fit: BoxFit.fitWidth)),
          Center(
              child: sharedText(
                  text: model.title,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Center(
              child: sharedText(
                  text: model.body,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFB6B6B6)))
        ],
      );
}
