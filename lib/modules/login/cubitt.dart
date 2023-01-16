import 'package:flutter_bloc/flutter_bloc.dart ';
import 'package:shop_app/modules/login/state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit() : super (ShopLoginInitialState());
  
  static ShopLoginCubit get(context) => BlocProvider.of(context);

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
        print(value.data);
        emit(ShopLoginSuccessState());

        }).catchError((error){
          emit(ShopLoginErrorState(error.toString()));
      });
  }
}