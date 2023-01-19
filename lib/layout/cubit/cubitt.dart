import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit () : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen (),
    const SettingsScreen(),
  ];
  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, query: null,).then((value) {

      print(homeModel.toString());

      homeModel = HomeModel.fromJson(value.data);

      emit(ShopSuccesHomeDataState());
    }).catchError(error)
    {
      print(error.toString());
      emit(ShopErrorHomeState());
    });
  }
}