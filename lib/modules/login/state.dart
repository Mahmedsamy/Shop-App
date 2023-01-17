import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginState {
  var loginModel;
}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState
{

  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState
{
  final String error;

  ShopLoginErrorState(this.error);

}
