import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubitt.dart';
import 'package:shop_app/modules/login/state.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';

class LoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

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

        CacheHelper.saveData(
        key: 'token',
        value: state.loginModel.data?.token,
        ).then( (value) {

          token = state.loginModel.data?.token;

        navigateAndFinish(
        context,
        const ShopLayout(),
        );
        });
        } else {
          debugPrint(state.loginModel.message);

          showToast(
              message: state.loginModel.message!,
              states: ToastStates.ERROR,
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
                              } else {
                                return null;
                              }
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
                              } else {
                                return null;
                              }
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
                           isUpperCase: true,
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
            ),
          );
        },
      ),
    );
  }
}
