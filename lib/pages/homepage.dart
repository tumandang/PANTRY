import 'package:cubaantest/components/fooditem.dart';
import 'package:cubaantest/models/food.dart';
import 'package:flutter/material.dart';
import 'package:cubaantest/models/category.dart';

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
  return myFood.where((f) => f.category == myCategory[selectedIndex].name).toList();
}
  

  String category ='';
  void filtercategory( String categoryselect){
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

              SizedBox(height: 25),

              // Text(
              //           'No Student Eats Alone.',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'SpecialGhotic',
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold
              //           ),
              //         ),
              SizedBox(height: 25),

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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        myCategory.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              height: 105,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: selectedIndex == index
                                    ? Border.all(width: 2.5, color: Colors.grey.shade700)
                                    : Border.all(color: Colors.white),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 47,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                124,
                                                0,
                                                0,
                                                0,
                                              ),
                                              offset: Offset(0, 5),
                                              blurRadius: 10,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Center(
                                          child: Image.asset(
                                            myCategory[index].image,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    myCategory[index].name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'CalSans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
