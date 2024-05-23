// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/model/favorite_model.dart';
// import '../../data/model/product_model.dart';
// import '../../domain/db_helper.dart';
//
// import '../../domain/db_helper_fav.dart';
// import '../provider/favorite_product_provider.dart';
// import '../provider/product_cart_provider.dart';
//
//
// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({Key? key}) : super(key: key);
//
//   @override
//   _FavoriteScreenState createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   //DBHelper? dbHelper = DBHelper();
//   DBHelperFav dbHelperFav=DBHelperFav();
//
//   @override
//   Widget build(BuildContext context) {
//     final favorite = Provider.of<FavoritesProductProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Center(child: const Text('Favorite')),
//         centerTitle: true,
//
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             FutureBuilder<List<FavoriteProductModel>>(
//               future: context.read<FavoritesProductProvider>().getData(),
//               builder: (context,  snapshot) {
//                 //print("Data retrieved: ${snapshot.data}");
//                 if (snapshot.hasData) {
//                   if (snapshot.data!.isEmpty) {
//                     return Align(
//                       alignment: Alignment.center,
//                       child: Center(
//                         child: Text(
//                           'Your cart is empty 😌',
//                           style: Theme.of(context).textTheme.headlineSmall,
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           final product = snapshot.data![index];
//                           return SingleChildScrollView(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Stack(
//                                     children: [
//                                       Container(
//                                         height: 250,
//                                         width: 350,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           border: Border.all(color: Colors.black45),
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             ClipRect(
//                                               clipBehavior: Clip.antiAlias,
//                                               child: Stack(
//                                                 children: [
//                                                   Image(
//                                                     height: 250 / 1.5,
//                                                     width: 320,
//                                                     fit: BoxFit.fill,
//                                                     image: NetworkImage(product.image.toString()),
//                                                   ),
//
//                                                   Container(
//                                                     height: 30,
//                                                     width: 90,
//                                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
//                                                     child: Center(
//                                                       child: Text(
//                                                         '\$${product.price}',
//                                                         style: TextStyle(fontSize: 20, color: Colors.green,fontWeight: FontWeight.bold),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                crossAxisAlignment: CrossAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     product.title.toString().substring(0,18),
//                                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Spacer(),
//                                                   Positioned(
//                                                       bottom: 1,
//                                                       right: 1,
//                                                       child: IconButton(onPressed: () {  }, icon: Container(
//                                                           decoration: BoxDecoration(
//                                                               borderRadius: BorderRadius.circular(20),
//                                                               color: Colors.green
//
//                                                           ),
//                                                           child: Icon(Icons.add,color: Colors.white,)),
//
//                                                   ))
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//
//
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 }
//                 return Center(child: CircularProgressIndicator()
//                 );},
//
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/favorite_model.dart';
import '../../domain/db_helper_fav.dart';
import '../provider/favorite_product_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorite = context.watch<FavoritesProductProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: const Text('Favorite')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder<List<FavoriteProductModel>>(
              future: favorite.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Your cart is empty 😌',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 250,
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black45),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      product.image.toString(),
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.title.toString().substring(0, 18),
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '\$${product.price}',
                                          style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.green,
                                            ),
                                            child: Icon(Icons.add, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
