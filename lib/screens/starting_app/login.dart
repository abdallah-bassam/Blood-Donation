import 'package:blood_donation/screens/donor_home_layout/donor_home.dart';
import 'package:blood_donation/screens/starting_app/sign_up.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/network/remote/dio_helper.dart';
import '../admin_home_layout/admin_home_layout.dart';
import '../donor_home_layout/donor_home_layout.dart';
import 'forget_password.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BloodDonationCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(right: 30,left:30 ,bottom: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sharedText(text: 'Sign in into your account', fontSize: 24, fontWeight: FontWeight.bold),
                            sharedText(text: 'Good to see you again, enter your details below.', fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFFB6B6B6)),
                          ],
                        ),
                        SizedBox(height: 60,),

                        sharedTextFormField(controller: cubit.emailController, validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;

                        }, label: 'Email Address',suffix: Icons.person,isPassword: false),
                        SizedBox(height: 15,),
                        sharedTextFormField(controller: cubit.passwordController, validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please enter an password';
                          }
                          if (!passwordRegex.hasMatch(value)) {
                            return 'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character';
                          }
                          return null;
                        }, label: 'Password',suffix: cubit.suffixPassword,isPassword: cubit.isPassword,
                            onPressedSuffix: (){
                          cubit.changePasswordIcon();
                          cubit.changeIsPassword();
                            }),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              cubit.changeRememberMeIcon();
                            }, icon: Icon(cubit.rememberMeIcon)),
                            sharedText(text: 'Remember Me', fontSize: 16),
                            Spacer(),
                            TextButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgetPassword()),
                              );
                            }, child: sharedText(text: 'Forget Password?', fontSize: 18))
                          ],
                        ),
                        SizedBox(height: 60,),
                        sharedMaterialButtonAccount(onPressed: ()async{
                          if(formKey.currentState!.validate())
                          {

                            DioHelper.postToDatabase(
                              url: 'api/login',
                              data: {'email': cubit.emailController.text, 'password': cubit.passwordController.text},
                            ).then((value) {
                              if (value.data['Status']) {
                                DioHelper.getDatabase(url: 'api/Donors/id/${value.data['id']}').then((value) {
                                  userDonor = value.data;
                                  cubit.firstNameController.text = userDonor['first_Name'];
                                  cubit.lastNameController.text = userDonor['last_Name'];
                                  cubit.ageController.text = userDonor['age'].toString();
                                  cubit.phoneNumberController.text = userDonor['phone'].toString();
                                  cubit.emailController.text = userDonor['username'];
                                  cubit.passwordController.text = userDonor['password'];
                                  cubit.confirmPasswordController.text = userDonor['password'];
                                  userDonor['username'].toString().contains('admin') ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (loginContext) => AdminHomeLayout()),
                                  ) : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (loginContext) => DonorHomeLayout()),
                                  );
                                }).catchError((error) {
                                  print(error.toString());
                                });
                              }
                              else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: null,
                                      content: sharedText(
                                        text: 'Email or Password Not Correct',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Try again'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }).catchError((error) {});}
                        },text: "Login"),
                        SizedBox(height: 60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sharedText(text: "Don't have an account?", fontSize: 18),
                            SizedBox(width: 5,),
                            TextButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp()),
                              );
                            }, child: sharedText(text: 'Sign Up', fontSize: 18))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
