import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubitt.dart';
import 'package:shop_app/modules/register/state.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';

class RegisterScreen extends StatelessWidget {

   RegisterScreen({Key? key}) : super(key: key);



  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return  BlocProvider(
  create: (BuildContext context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
  listener: (context, state)
  {
    if(state is ShopRegisterSuccessState)
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
      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Register now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  defaultTextFormField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    label: "Name",
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'please enter your name address';
                      } else {
                        return null;
                      }
                    },
                    prefix: Icons.person,
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

                  const SizedBox(
                    height: 30.0,
                  ),


                  defaultTextFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      label: "Phone",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter your phone address';
                        } else {
                          return null;
                        }
                      },
                      prefix: Icons.phone),

                          const SizedBox(
                             height: 10.0,
                                ),


                  ConditionalBuilder(
                    condition: state is ! ShopRegisterLoadingState,
                    builder: (context) => defaultButton(
                      function: ()
                      {
                        if (formKey.currentState!.validate())
                        {
                          ShopRegisterCubit.get(context).userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: 'register',
                      isUpperCase: true,
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
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
