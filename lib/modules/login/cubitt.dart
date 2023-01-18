import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart ';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit() : super (ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
    required String password,
})
  {
    emit (ShopLoginLoadingState());

      DioHelper.postData(
        url: LOGIN,
        data:
          {
          'email' : 'email',
          'password' : 'password',
          },
      ).then((value)
      {
        debugPrint(value.data);

        loginModel =ShopLoginModel.formJson(value.data);


        emit(ShopLoginSuccessState(loginModel!));

        }).catchError((error){
        debugPrint(error.toString());
          emit(ShopLoginErrorState(error.toString()));
      });
  }
}