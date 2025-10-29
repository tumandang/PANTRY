import 'package:pantry/models/cartmanager.dart';
import 'package:flutter/material.dart';
import 'package:pantry/models/food.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartQRPage extends StatefulWidget {
  const CartQRPage({super.key});

  @override
  State<CartQRPage> createState() => _CartQRPageState();
}

class _CartQRPageState extends State<CartQRPage> {
  List<Food> _foods = [];
  bool isLoading = true;
 

  void initState() {
    super.initState();
    fetchFoodFromWebsite();
  }



  Future<void> fetchFoodFromWebsite() async {
    try {
      final response = await http.get(
        Uri.parse('https://eduhosting.top/campusfoodpantry/get_food.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _foods = data.map((item) => Food.fromJson(item)).toList();
          isLoading = false;
        });
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,

        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () {
              Provider.of<Cartmanager>(context, listen: false).clear();
            },
          ),
        ],
      ),
      body: Consumer<Cartmanager>(
        builder: (context, value, child) {
          if (value.items.isEmpty) {
            return const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.items.length,
                  padding: const EdgeInsets.all(12.0),
                  itemBuilder: (context, index) {
                    final item = value.items[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),

                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    bottomLeft: Radius.circular(7),
                                  ),
                                ),

                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    Provider.of<Cartmanager>(
                                      context,
                                      listen: false,
                                    ).updateQuantity(
                                      item.id,
                                      item.quantity - 1,
                                    );
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  child: Text(
                                    "${item.quantity}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Provider.of<Cartmanager>(
                                      context,
                                      listen: false,
                                    ).updateQuantity(
                                      item.id,
                                      item.quantity + 1,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () => Provider.of<Cartmanager>(
                              context,
                              listen: false,
                            ).removeItem(item.id),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Items',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${value.totalItems} ",
                            style: TextStyle(
                              fontFamily: 'SpecialGothic',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationModal(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          padding: EdgeInsets.all(12),

                          child: Row(
                            spacing: 4,
                            children: [
                              Icon(
                                Icons.trolley,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                'Pickup Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CalSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ConfirmationModal extends StatefulWidget {
  const ConfirmationModal({super.key});

  @override
  State<ConfirmationModal> createState() => _ConfirmationModalState();
}

class _ConfirmationModalState extends State<ConfirmationModal> {
  String? id;
    Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
     id = prefs.getString('id') ?? 'IDStudent';
     
    });
  }

  Future<void> postOrderQR(BuildContext context) async {
    try {
      
      await loaduserdata();

      if (id == null || id!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Missing student ID")),
        );
        return;
      }

      


      
      final cart = Provider.of<Cartmanager>(context, listen: false);
      final items = cart.items.map((e) => '${e.name} (${e.quantity})').join(', ');

      
      final response = await http.post(
        Uri.parse('https://eduhosting.top/campusfoodpantry/api_walkin.php'),
        body: {
          'studentID': id,
          'item': items,
        },
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pick-Up order recorded successfully!")),
        );

        cart.clear();
        Navigator.pushNamed(context, '/OrderHistory');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Pickup failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Confirm Pickup Order?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => postOrderQR(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Yes, Confirm",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}



