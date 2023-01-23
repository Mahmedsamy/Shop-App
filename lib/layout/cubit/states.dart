

import 'package:shop_app/layout/cubit/states.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccesHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccesCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}