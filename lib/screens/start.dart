import 'package:blood_donation/screens/admin_home_layout/admin_home_layout.dart';
import 'package:blood_donation/screens/donor_home_layout/donor_home_layout.dart';
import 'package:blood_donation/screens/sign_up.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUp()),
                );
              },child: sharedText(text: 'Donor', fontSize: 22,color: Colors.white),),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminHomeLayout()),
                );
              },child: sharedText(text: 'Blood Bank', fontSize: 22,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
