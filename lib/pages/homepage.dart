import 'package:pantry/components/fooditem.dart';
import 'package:pantry/models/food.dart';
import 'package:flutter/material.dart';
import 'package:pantry/models/category.dart';
import 'package:intl/intl.dart';

class HomeContentPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Hazriq 👋',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              fontFamily: 'CalSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('dd MMM yyyy').format(DateTime.now()),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 13,
                            ),
                          ),
                        ],
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
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Seacrh',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Text(
              //           'No Student Eats Alone.',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'SpecialGhotic',
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold
              //           ),
              //         ),
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
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.amber.shade700
                                    : Colors.grey.shade300,
                                width: selectedIndex == index ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
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
              
               Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                padding: EdgeInsets.all(12),
                child: Center(child: Text('Banner')),
                
              ),


              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.all(5.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Top Pick Up',
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    ...List.generate(
                      filteredFood.length,
                      (index) => Padding(
                        padding: index == 0
                            ? EdgeInsets.only(left: 10, right: 10)
                            : EdgeInsets.only(right: 10),
                        child: Fooditem(FoodModel: filteredFood[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
