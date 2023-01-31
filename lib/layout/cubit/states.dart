


import 'package:shop_app/models/change_favorite_model.dart';

abstract class ShopStates {}

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

class ShopSuccesGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}
