
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/state.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState
{

  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState
{
  final String error;

  ShopRegisterErrorState(this.error);

}

class ShopRegisterChangePasswordVisibiltyState extends ShopLoginState {}
