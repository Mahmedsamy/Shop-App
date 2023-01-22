import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/styles/themes.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

   bool isDark = CacheHelper.getData (key: 'isDark')??false;

  Widget widget;

  bool onBoarding = CacheHelper.getData (key: 'onBoarding')??false;

   token = CacheHelper.getData(key: 'token')??'';

  if (onBoarding) {
      if (token.isNotEmpty) {
        widget = const ShopLayout();
      } else {
        widget = LoginScreen();
      }
    } else {
        widget = const OnBoardingScreen();
      }

  runApp(MyApp(
    isDark: isDark,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});



  final bool isDark;
  final Widget widget;

   const MyApp({ required this.isDark, required this.widget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       return  MultiBlocProvider(
           providers: [
             BlocProvider(
                 create: (BuildContext context) => AppCubit()),
             // BlocProvider(
             //   create: (BuildContext context) => ShopCubit()
             //       ..getHomeData()
             //    //   ..getCategoriesData()
             //    //  ..getFavoritesData()
             //    // ..getUserData()
             // ),
              BlocProvider(
              create: (BuildContext context) => ShopCubit()..getHomeData(),),
          ],
           child: BlocConsumer<AppCubit, AppStates>(
           listener: (context, state) {},
           builder: (context, state) {
             return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme ,
                darkTheme: darkTheme ,
                //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home : widget,
    );
   }
  ),
  );
}
}


