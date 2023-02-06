import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';

import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';



class SettingsScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

  SettingsScreen({super.key});

  final formkey =GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {

      },
      builder: (context, state) {

        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;

        return ConditionalBuilder(
          //condition: ShopCubit.get(context).userModel != null,
          condition: cubit.userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUpdateUserState)
                  LinearProgressIndicator(),
                  defaultTextFormField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    validate: (dynamic value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  defaultTextFormField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    validate: (dynamic value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  defaultTextFormField(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    validate: (dynamic value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone ',
                    prefix: Icons.phone_android,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                    function: () {

                      if(formkey.currentState!.validate())
                     {
                       ShopCubit.get(context).updateUserData(
                         name: nameController.text,
                         email: emailController.text,
                         phone: phoneController.text,
                       );
                     }
                    },
                    text: 'update',
                    isUpperCase: true   ,
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'logout',
                        isUpperCase: true   ,
                    ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
