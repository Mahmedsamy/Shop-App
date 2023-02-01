import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:  const Text(
            'SALLA'
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: ()
                {
                navigateTo(context, const SearchScreen(),);
                },
            ),],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex ,
              items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
              label:'Home ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label:'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label:'favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label:'settings',
              ),

            ],
          ),
    );
    },
    );
  }
}
