import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/cubitt.dart';
import 'package:shop_app/modules/login/state.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/shared/components.dart';

class LoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passController = TextEditingController();


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit() ,
      child: BlocConsumer <ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if (state.loginModel.status!)
            {
              debugPrint(state.loginModel.message);
              debugPrint(state.loginModel.data?.token);

              Fluttertoast.showToast(
                  msg: "state.loginModel.message",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            } else
            {
              debugPrint(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: "state.loginModel.message",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          }
        },

        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
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

                        const SizedBox(
                          height: 30.0,
                        ),

                        defaultTextFormField(
                            controller: passController,
                            textInputType: TextInputType.visiblePassword,
                            onSubmit: (value)
                            {
                              if (formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passController.text,
                                );
                              }
                            },
                            //ispassword: true,
                            label: "Password",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your Password';
                              } else
                                return null;
                            },
                            prefix: Icons.lock_outline),

                        ConditionalBuilder(
                         condition: state is ! ShopLoginLoadingState,
                         builder: (context) => defaultButton(
                           function: ()
                           {
                             if (formKey.currentState!.validate())
                             {
                               ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passController.text,
                               );
                             }

                           },
                           text: 'login',
                           isUpperCace: true,
                         ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),



                        const SizedBox(
                          height: 30.0,
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('dont/t have an account?'),

                            defaultTextButton(
                                onPress: () {
                                  navigateTo(
                                      context,
                                      const RegisterScreen());
                                },
                                text: 'Register Here')
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
      ),
    );
  }
}
