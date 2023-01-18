import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
            'SALLA'
        ),
      ),
      body:  TextButton(
        onPressed: ()
        {
          CacheHelper.removeData(key:'token',).then((value){
            if (value)
            {
              navigateAndFinish(context, LoginScreen(),);
            }
          });
        },
        child: const Text(
            'SIGN OUT'
        ),
      ),
    );
    },
    );
  }
}
