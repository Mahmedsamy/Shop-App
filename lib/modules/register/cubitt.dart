import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart ';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterState>
{
  ShopRegisterCubit() : super (ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
})
  {
    emit (ShopRegisterLoadingState());

      DioHelper.postData(
        url: REGISTER,
        data: {
          "name" : name,
          "email" : email,
          "password" : password,
          "phone" : phone,
          },
      ).then((value)
      {
        debugPrint("value data ${value.data}");

        loginModel =ShopLoginModel.formJson(value.data);

      
        emit(ShopRegisterSuccessState(loginModel!));

        }).catchError((error){
        debugPrint(error.toString());
          emit(ShopRegisterErrorState(error.toString()));
      });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  // void changePasswordVisibility()
  // {
  //   isPassword = !isPassword;
  //   suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
  //
  //   emit(ShopRegisterChangePasswordVisibiltyState());
  // }
}