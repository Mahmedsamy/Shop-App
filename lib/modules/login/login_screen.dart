import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:shop_app/modules/login/cubitt.dart';
import 'package:shop_app/modules/login/state.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/shared/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passController = TextEditingController();


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit() ,
      child: BlocConsumer <ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
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

                      ConditionalBuilder(
                       condition: false,
                       builder: (context) => defaultButton(
                         function: () {},
                         text: 'login',
                         isUpperCace: true,
                       ),
                        fallback: (context) => CircularProgressIndicator(),
                      ),



                      SizedBox(
                        height: 30.0,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('dont have an account?'),

                          defaultTextButton(
                              onPress: () {
                                navigateTo(
                                    context,
                                    RegisterScreen());
                              },
                              text: 'Register Here')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
