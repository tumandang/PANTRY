import 'package:PANTRY/models/cartitem.dart';
import 'package:PANTRY/models/cartmanager.dart';
import 'package:PANTRY/models/food.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fooditem extends StatelessWidget {
  final Food FoodModel;
  const Fooditem({super.key, required this.FoodModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // Container(
        //   height: 205,
        //   width: size.width / 2.4,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        // ),
        Container(
          height: 290,
          width: size.width / 2.4,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey.shade400),
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 160,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(121, 0, 0, 0),
                                spreadRadius: 5,
                                blurRadius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(child: Image.asset(FoodModel.image, height: 100)),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FoodModel.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${FoodModel.stock} pcs",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    ElevatedButton.icon(
                      onPressed: () {
                        final foodtaken = CartItem(
                            id: FoodModel.id,
                            name: FoodModel.name,
                            category: FoodModel.category,
                            quantity: 1,
                            stock: (FoodModel.stock > 0) ? FoodModel.stock - 1 : 0,
                            imageUrl:FoodModel.image,
                          );
                          Provider.of<Cartmanager>(context, listen: false).additem(foodtaken);

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: 
                          //   Text("1 pcs ${FoodModel.name} added to cart"),
                          //   behavior: SnackBarBehavior.floating,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(24),

                          //     ),
                          //     margin: EdgeInsets.only(
                          //     bottom: MediaQuery.of(context).size.height - 100,
                          //     right: 20,
                          //     left: 20),
                          //   )
                            
                          // );
                      },
                      
                      icon: Icon(
                        Icons.add_shopping_cart_sharp,
                      ),
                      label: Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
                        foregroundColor:
                            Theme.of(context).colorScheme.surface,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), 
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
