import 'package:flutter/material.dart';
import 'package:shop_app/shared/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passController = TextEditingController();


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Login',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Login now to browse our hot offers',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),

          defaultTextFormField(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              label: "Email",
              validate: (value) {
                if (value.isEmpty) {
                  return 'please enter your email address';
                } else
                  return null;
              },
              prefix: Icons.email_outlined),
          SizedBox(
            height: 30.0,
          ),

          defaultTextFormField(
              controller: passController,
              textInputType: TextInputType.visiblePassword,
              label: "Password",
              validate: (value) {
                if (value.isEmpty) {
                  return 'please enter your Password';
                } else
                  return null;
              },
              prefix: Icons.lock_outline),
          defaultButton(
              function: () {},
              text: 'login',
              isUpperCace: true,
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Text('dont have an account?'),

            ],
          ),
        ],
      ),
    );
  }
}
