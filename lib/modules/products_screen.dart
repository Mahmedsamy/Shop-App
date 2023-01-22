import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit, ShopStates>
      (
      listener: (context, state) {},
      builder: (context, state)
      {
       return ConditionalBuilder(
           condition: ShopCubit.get(context).homeModel !=null,
           builder: (context) => productBuilder(ShopCubit.get(context).homeModel!),
           fallback: (context) => const Center(child: CircularProgressIndicator()),
       );
      },
    );
  }

  Widget productBuilder(HomeModel model) => Column(
    children: [
      CarouselSlider(
        items: model.data!.banners!.map((e) => Image(
          image: NetworkImage( e.image !),
          width: double.infinity,
          fit: BoxFit.cover ,
        ), ).toList(),
        options: CarouselOptions(
          height: 250.0,
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(model.data!.products!.length, (index) => Column(
            children: [
              Image(image: NetworkImage(model.data!.products![index].image!),
              ),
            ],
          ),
          ),
        ),
      ),

    ],
  );

}
