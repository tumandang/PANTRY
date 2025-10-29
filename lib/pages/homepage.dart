import 'package:pantry/components/homeitem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pantry/models/popularfood.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContentPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  int selectedIndex = 0;
  List<PopularFood> _foods = [];
  bool isLoading = true;
  String? userName;

  void initState() {
    super.initState();
    fetchFoodFromWebsite();
    loaduserdata();
  }

  Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'User';
    });
  }

  Future<void> fetchFoodFromWebsite() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://eduhosting.top/campusfoodpantry/api_popular_food.php',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        print("Raw API data: $jsonResponse");

        if (jsonResponse['success'] == true &&
            jsonResponse['popular_foods'] != null) {
          final List<dynamic> data = jsonResponse['popular_foods'];

          setState(() {
            _foods = data.map((item) => PopularFood.fromJson(item)).toList();
            isLoading = false;
          });

          print("Loaded foods: ${_foods.length}");
        } else {
          print("No foods found or success=false");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (e) {
      print('Error fetching food: $e');
      setState(() {
        isLoading = false;
      });
    }
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
                            'Hi, ${userName ?? "User"} ',
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


              SizedBox(height: 15),


              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/banner-1.jpg'),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                ),
                padding: EdgeInsets.all(12),
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
              if (isLoading)
                Center(child: CircularProgressIndicator(color: Colors.amber))
              else if (_foods.isEmpty)
                Center(
                  child: Text(
                    "No top pickup items available or Please connect to the Internet",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                        _foods.length,
                        (index) => Padding(
                          padding: index == 0
                              ? EdgeInsets.only(left: 10, right: 10)
                              : EdgeInsets.only(right: 10),
                          child: Homeitem(FoodModel: _foods[index]),
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