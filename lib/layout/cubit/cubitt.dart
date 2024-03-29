import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/fav_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
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
    SettingsScreen(),
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
    //  printFullText(homeModel.toString());

      homeModel = HomeModel.formJson(value.data);

      for (var element in homeModel!.data!.products!) {
        favorites.addAll({
          element.id!: element.inFavourites!,
        });
      }
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
     // printFullText(categoriesModel.toString());

      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorities (int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccesChangeFavoritesState(changeFavoritesModel!));


    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
     token: token,
    )
        .then((value) {

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      debugPrint(value.data);

       if (!changeFavoritesModel!.status!)
         {
           favorites[productId] = !favorites[productId]!;
         }
          emit(ShopSuccesChangeFavoritesState(changeFavoritesModel!));
    })
        .catchError((error) {

      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavModel? favModel;

  void getFavoritiesModel()
   {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
      query: null,
    ).then((value) {
     // printFullText(favModel.toString());

      favModel = FavModel.fromJson(value.data);

      // printFullText(value.data.toString());

      emit(ShopSuccesGetFavoritesState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShopLoginModel? userModel;

  // void getUserData()
  // {
  //   emit(ShopLoadinGetUserDataState());
  //
  //   DioHelper.getData(
  //     url: PROFILE,
  //     token: token,
  //     query: null,
  //   ).then((value) {
  //
  //     //printFullText(favModel.toString());
  //
  //     userModel = ShopLoginModel.formJson(value.data);
  //
  //   //  printFullText(userModel!.data!.name!);
  //
  //     emit(ShopSuccessUserDataState(userModel!));
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(ShopErrorUserDataState());
  //   });
  // }


  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
        url: PROFILE,
        query: null,
        lang: 'en',
        token: token)
        .then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
{
    emit(ShopLoadingUpdateUpdateUserState(userModel!));
    DioHelper.putData(
        url: UPDATE_PROFILE,
        query: null,
        lang: 'en',
        token: token,
        data: {
          'name' : name,
          'email' : email,
          'phone' : phone,
        },

    ).then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      emit(ShopLoadingUpdateUpdateUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
    });
  }

}
