import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super (ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen (),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    debugPrint("get Home Data ${token.isEmpty}");
    DioHelper.getData(
      url: HOME,
      token: token,
      query: null,
    ).then((value) {
      printFullText(homeModel.toString());

      homeModel = HomeModel.fromJson(value.data);

      homeModel?.data?.products?.forEach((element)
      {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      debugPrint(favorites.toString());

      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;

  void getCategoriesModel()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
      query: null,
    ).then((value) {
      printFullText(categoriesModel.toString());

      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorities (int productId)
  {
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
      token: token,
    )
        .then((value) {
          emit(ShopSuccesChangeFavoritesState());
    })
        .catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }
}
