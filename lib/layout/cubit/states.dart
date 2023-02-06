


import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {
}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccesHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccesCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccesChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccesGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}


// class ShopLoadingGetUserDataState extends ShopStates{}
//
// class ShopSuccesGetUserDataState extends ShopStates
// {
//    final ShopLoginModel loginModel;
//
//    ShopSuccesGetUserDataState(this.loginModel);}
//
// class ShopErrorGetUserDataState extends ShopStates{}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessUpdateUserDataState(this.userModel);

}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}
////////////////////////////////////////////////////



class ShopSuccessUpdateUserState extends ShopStates {
  late final ShopLoginModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates {
  late final String error;

  ShopErrorUpdateUserState(this.error);
}

class ShopLoadingUpdateUpdateUserState extends ShopStates {
  final ShopLoginModel userModel;

  ShopLoadingUpdateUpdateUserState(this.userModel);
}

class ShopSuccessUpdateUpdateUserState extends ShopStates {
  late final ShopLoginModel userModel;

  ShopSuccessUpdateUpdateUserState(this.userModel);
}