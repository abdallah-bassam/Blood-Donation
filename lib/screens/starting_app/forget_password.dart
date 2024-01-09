import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          sharedText(text: 'Forget Password', fontSize: 30, fontWeight: FontWeight.bold),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: sharedText(
                          text: 'Send Email', fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  sharedTextFormField(
                      controller: codeController,
                      validator: (value) {},
                      isPassword: false,
                      label: 'Code',
                      width: 100),
                ],
              ),
              SizedBox(height: 40,),
              sharedTextFormField(
                  controller: newPasswordController,
                  validator: (value) {},
                  label: 'New Password',
                  isPassword: true,
                  suffix: Icons.visibility_off),
              SizedBox(
                height: 15,
              ),
              sharedTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {},
                  label: 'Confirm Password',
                  isPassword: true,
                  suffix: Icons.visibility_off),
              SizedBox(height: 40,),
              sharedMaterialButtonAccount(onPressed: (){},text: "Edit Password"),
            ],
          ),
        ],
      ),
    );
  }
}
