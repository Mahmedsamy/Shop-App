import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubitt.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/fav_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit , ShopStates >(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              buildFavItem(ShopCubit.get(context).favModel!.data.data[index]),
          separatorBuilder: (context, index) => divider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );

  }

  Widget buildFavItem(FavData data) => Padding(
    padding:  const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
               Image(
                image: NetworkImage("https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg".replaceFirst("s", "")),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
              if (1 != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  color: Colors.red,
                  child: Text(
                    'discount'.toUpperCase(),
                    style: const TextStyle(fontSize: 9.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      '2000',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 16.0,
                          height: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (1 != 0)
                      const Text(
                        "5000",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: const CircleAvatar(
                        radius: 15.0,
                        backgroundColor:  true // ShopCubit.get(context).favorites[model.id!]!
                            ? defaultColor
                            : Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // ShopCubit.get(context).changeFavorites(model.id!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
