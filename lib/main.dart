import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/shop_layout.dart';
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

   bool isDark = CacheHelper.getData (key: 'isDark')??false;

   Widget widget;

  bool onBoarding = CacheHelper.getData (key: 'onBoarding')??false;

  String token = CacheHelper.getData(key: 'token');

  if (onBoarding != null)
    {
      if (token != null) widget = ShopLayout();
      else widget = LoginScreen();
    } else
      {
        widget = OnBoardingScreen();
      }

  runApp(  MyApp(
    isDark: isDark,
    startWidget: widget,
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
      return  MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) => ShopCubit()..getBusiness()),
            BlocProvider(create: (BuildContext context) => ShopCubit()),
            BlocProvider(
                create: (BuildContext context) => ShopCubit()
                  ..getHomeData()
                  ..getCategoriesData()
                  ..getFavoritesData()
                  ..getUserData()),
            BlocProvider(
                create: (BuildContext context) => ShopCubit(),
                  //..getUserData()
                  //..getPosts()),
          ),
          ],
          child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
             return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme ,
                darkTheme: darkTheme ,
                //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home : startWidget(),
    );
   },
   ),
  );
}
}


