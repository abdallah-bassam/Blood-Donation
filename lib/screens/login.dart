import 'package:blood_donation/screens/sign_up.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                 //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sharedText(text: 'Sign in into your account', fontSize: 24, fontWeight: FontWeight.bold),
                          sharedText(text: 'Good to see you again, enter your details below.', fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xFFB6B6B6)),
                        ],
                      ),
                      SizedBox(height: 60,),

                      sharedTextFormField(controller: cubit.emailController, validator: (value){}, label: 'Email Address',suffix: Icons.person,isPassword: false),
                      SizedBox(height: 15,),
                      sharedTextFormField(controller: cubit.passwordController, validator: (value){}, label: 'Password',suffix: cubit.suffixPassword,isPassword: cubit.isPassword,
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
                          TextButton(onPressed: (){}, child: sharedText(text: 'Forget Password?', fontSize: 18))
                        ],
                      ),
                      SizedBox(height: 60,),
                      sharedMaterialButtonAccount(onPressed: (){
                        cubit.userLogin(email: cubit.emailController.text,password: cubit.passwordController.text);
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
        );
      },
    );
  }
}
