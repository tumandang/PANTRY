import 'dart:convert';
import 'package:pantry/components/fooditem.dart';
import 'package:pantry/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:async';
// 
import '../models/food.dart';

class FoodPage extends StatefulWidget {
  FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;
  List<Food> _foods = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  Timer? _debounce;

  void initState() {
    super.initState();
    fetchFoodFromWebsite();
  }

  Future<List<double>> getEmbedding(String text) async {
    final response = await http.post(
      Uri.parse("https://eduhosting.top/campusfoodpantry/smart_search.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": text}),
    );

    final data = json.decode(response.body);
    return List<double>.from(data["data"][0]["embedding"]);
  }

  List<Map<String, dynamic>> foodData = [];
  List<List<double>> foodVectors = [];
  Future<void> fetchFoodFromWebsite() async {
    try {
      final response = await http.get(
        Uri.parse('https://eduhosting.top/campusfoodpantry/get_food.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        _foods = data.map((item) => Food.fromJson(item)).toList();
        isLoading = false;
        foodData = List<Map<String, dynamic>>.from(data);

        for (var food in foodData) {
          final vector = await getEmbedding(food['name']);
          foodVectors.add(vector);
        }

        if (!mounted) return;
        setState(() {});
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (e) {
      print('Error fetching food: $e');
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  String normalizeSearch(String query) {
    query = query.toLowerCase();

    final Map<String, List<String>> keywordMap = {
      "noodle": ["maggi", "mee", "ramen"],
      "noodles": ["maggi", "mee", "ramen"],
      "instant": ["maggi", "mee"],
      "drink": ["beverage", "water", "tea", "milo"],
      "snack": ["lexus", "biscuit", "chips"],
      "bread": ["gardenia", "bun"],
    };

    // If user types a keyword we know → replace it
    for (var key in keywordMap.keys) {
      if (query.contains(key)) {
        // Join all mapped words as one combined search string
        return keywordMap[key]!.join(" ");
      }
    }

    return query;
  }

  List<Food> get filteredFood {
    if (selectedIndex == 0) return _foods;
    return _foods
        .where((f) => f.category == myCategory[selectedIndex].name)
        .toList();
  }

  String category = '';
  void filtercategory(String categoryselect) {
    setState(() {
      category = categoryselect;
    });
  }

  double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0, normA = 0, normB = 0;
    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    return dot / (sqrt(normA) * sqrt(normB));
  }

  Future<List<Food>> semanticSearch(String query) async {
    final queryVector = await getEmbedding(query);

    List<Map<String, dynamic>> scored = [];
    for (int i = 0; i < foodVectors.length; i++) {
      final sim = cosineSimilarity(foodVectors[i], queryVector);
      scored.add({"food": Food.fromJson(foodData[i]), "similarity": sim});
    }

    scored.sort((a, b) => b["similarity"].compareTo(a["similarity"]));

    return scored.take(2).map((e) => e["food"] as Food).toList();
  }
  //post API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,

      body: SafeArea(
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.amber,
                      strokeWidth: 4,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Loading Food List :)",
                      style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'SpecialGhotic',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Together Against Hunger.',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                fontFamily: 'SpecialGhotic',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '~Brain.Freeze(); Team',
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
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchQuery = value;

                        // Cancel any previous timer
                        if (_debounce?.isActive ?? false) _debounce!.cancel();

                        // Start new timer
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () async {
                            if (value.isEmpty) {
                              setState(() {
                                _foods = List<Food>.from(
                                  foodData.map((item) => Food.fromJson(item)),
                                );
                                searchQuery = '';
                              });
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            final results = await semanticSearch(value);
                            if (!mounted) return;

                            setState(() {
                              _foods = results;
                              isLoading = false;
                            });
                          },
                        );
                      },

                      decoration: InputDecoration(
                        hintText: 'Search food...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    searchQuery = '';
                                    _foods = List<Food>.from(
                                      foodData.map(
                                        (item) => Food.fromJson(item),
                                      ),
                                    );
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
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
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
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
                                            colors: [
                                              Color(0xFFFFC107),
                                              Colors.white,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                            ],
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
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
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
                        shrinkWrap: true,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
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