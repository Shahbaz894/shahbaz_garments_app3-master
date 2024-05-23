import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahbaz_garments_app/ui/screen/product_detail_screen.dart';

import '../../data/model/favorite_model.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/product_reppository.dart';
import '../../domain/db_helper.dart';
import '../../domain/db_helper_fav.dart';
import '../provider/product_cart_provider.dart';

class ProductGridViewScreen extends StatefulWidget {
  @override
  State<ProductGridViewScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductGridViewScreen> {
  DBHelper? dbHelper = DBHelper();
  DBHelperFav dbHelperFav=DBHelperFav();
  @override
  Widget build(BuildContext context) {
    final myProductProvider = Provider.of<MyProductProvider>(context);

    final cartProvider = Provider.of<ProductCartProvider>(context);

    return Scaffold(

      body: FutureBuilder<void>(
        future: myProductProvider.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (myProductProvider.myDataList.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            return
              GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2,
                ),
                itemCount: myProductProvider.myDataList.length,
                itemBuilder: (BuildContext ctx, index) {
                  final product = myProductProvider.myDataList[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to product detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            title: product.title.toString(),
                            productImage: product.image.toString(),
                            productPrice: product.price,
                            productDescription: product.description.toString(),

                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        border: Border.all(color: Colors.purpleAccent,
                        width: 3),
                        boxShadow: const [BoxShadow(

                          blurRadius: 35,
                          color: Colors.white60
                        )],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              // Product image
                              Image.network(
                                product.image.toString(),
                                fit: BoxFit.fill,
                                height: 170, // Adjust as needed
                              ),
                              SizedBox(height: 20,),


                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );


          }
        },
      ),
    );
  }
}