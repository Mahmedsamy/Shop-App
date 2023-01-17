import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/styles/themes.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

   bool isDark = CacheHelper.getData (key: 'isDark');

  bool onBoarding = CacheHelper.getData (key: 'onBoarding');



  runApp(  MyApp(
    isDark: isDark,
    onBoarding: onBoarding,
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});



  final bool isDark;
  final bool onBoarding;

   const MyApp
      ({ required this.isDark, required this.onBoarding});


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
                  home :  onBoarding ? LoginScreen() :   const OnBoardingScreen(),
    );
  // },
  // ),
  // );
}
}


