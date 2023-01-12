import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/styles/themes.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  //awit CacheHelper.init();

  //bool isDark = CacheHelper.getBoolean (key: 'isDark');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


 // final bool isDark;

 // MyApp(this.isDark);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // return  MultiBlocProvider(
      //     providers:
      //     [
      //       BlocProvider(
      //         create: (BuildContext context) => di<AppCubit>(),
      //       ),
      //     ],
      //     child: BlocConsumer<AppCubit, AppStates>(
      //     listener: (BuildContext context, AppStates state) {},
      //     builder: (BuildContext context, AppStates state)
      //     {
             return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme ,
                darkTheme: darkTheme ,
                //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home :  OnBoardingScreen(),
    );
  // },
  // ),
  // );
}
}


