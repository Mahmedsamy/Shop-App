import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components.dart';


class SettingsScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

  SettingsScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        nameController.text = state.loginModel.data.name;
        emailController.text = state.loginModel.data.email;
        phoneController.text = state.loginModel.data.phone;

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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

              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
