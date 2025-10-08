import 'package:pantry/components/fooditem.dart';
import 'package:pantry/models/category.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  List<Food> get filteredFood {
    if (selectedIndex == 0) return myFood;
    return myFood
        .where((f) => f.category == myCategory[selectedIndex].name)
        .toList();
  }

  String category = '';
  void filtercategory(String categoryselect) {
    setState(() {
      category = categoryselect;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Hazriq!',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: 'SpecialGhotic',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '21 Dec 2024',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),

                  //CART
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cartpage');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      'Seacrh',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              // Text(
              //           'No Student Eats Alone.',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'SpecialGhotic',
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold
              //           ),
              //         ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Search by Category',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontFamily: 'SpecialGhotic',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: List.generate(
                      myCategory.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: selectedIndex == index
                                  ? const LinearGradient(
                                      colors: [Color(0xFFFFC107), Colors.white],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : const LinearGradient(
                                      colors: [Colors.white, Colors.white],
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.amber.shade700
                                    : Colors.grey.shade300,
                                width: selectedIndex == index ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  myCategory[index].image,
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  myCategory[index].name,
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.grey.shade800,
                                    fontFamily: 'CalSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.all(5.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${filteredFood.length} results',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontFamily: 'SpecialGhotic',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (0.6),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: filteredFood.length,
                  itemBuilder: (context, index) {
                    final food = filteredFood[index];
                    return Fooditem(FoodModel: food);
                  },
                ),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   physics: BouncingScrollPhysics(),
              //   child: Row(
              //     children: [
              //       ...List.generate(
              //         filteredFood.length,
              //         (index) => Padding(
              //            padding: EdgeInsets.only(bottom: 10),
              //           child: Fooditem(FoodModel: filteredFood[index]),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


