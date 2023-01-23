import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/Products_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/constants.dart';

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

  Widget productBuilder(HomeModel model) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(

          items: model.data!.banners!.map((e) => Image(
            image: NetworkImage( e.image!.replaceFirst("s", "")),
            width: double.infinity,
            fit: BoxFit.cover ,
          ), ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
            'Categories',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          height: 100.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => buildCategoryItem() ,
              separatorBuilder: (context, index) => const SizedBox(
                width: 20.0 ,
              ),
              itemCount: 10,
          ),
        ),
        const Text(
          'News Products',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
          Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 0.9,
            children: List.generate(
              model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index]),

            ),
          ),
        ),

      ],
    ),
  );

  Widget buildCategoryItem() => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children:  [
      const Image(image: NetworkImage('http://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8,),
        width: 100.0,
        child: const Text(
          'Electronics',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct (Products model) =>  Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!.replaceFirst("s", "")),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child:  const Text(
                'Discount',
                    style: TextStyle(
                    fontSize: 10.0,
                    color:Colors.white,
               ),
              ),
            ),
          ],
        ),
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 model.name,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(
                   fontSize: 12.0,
                   height: 1.1,
                 ),
               ),
               Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,),
                  if(model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                        Icons.favorite_border,
                      size: 20.0,
                    ),
                    onPressed: () {},
                  ),
                ],
        ),
             ],
           ),
         ),

      ],
    ),
  );
}
