import 'package:pantry/models/cartmanager.dart';
import 'package:flutter/material.dart';
import 'package:pantry/models/food.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                                'Order Now',
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

class ConfirmationModal extends StatelessWidget {
  const ConfirmationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          CardDiaglog(),
          Positioned(
            top: 0,
            right: 0,

            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                iconColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Icon(Icons.close_rounded, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDiaglog extends StatefulWidget {
  const CardDiaglog({super.key});

  @override
  State<CardDiaglog> createState() => _CardDiaglogState();
}

class _CardDiaglogState extends State<CardDiaglog> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
   String? id;

    Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id') ?? 'User';
    });
  }
    Future<void> postorder({
    required String date,
    required String time,
    required List<Map<String, dynamic>> items,
  }) async {
    await loaduserdata();
    try {
      final response = await http.post(
        Uri.parse('https://eduhosting.top/campusfoodpantry/api_order.php'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          'studentID': id,
          'date': date,
          'time': time,
          'items': items,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Order submitted successfully",style: TextStyle(color: Colors.red))),
          );
           Provider.of<Cartmanager>(context, listen: false).clear();
           Navigator.pushNamed(context, '/OrderHistory');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Order failed',style: TextStyle(color: Colors.red))),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}',style: TextStyle(color: Colors.red))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e',style: TextStyle(color: Colors.red))));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_checkout_rounded,
              size: 50,
              color: Colors.green[700],
            ),
            Text(
              "Your order has been placed!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'CalSans',
              ),
            ),
            Text(
              "Please let me know the time and date",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'SpecialGothic',
              ),
            ),

            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                filled: true,
                prefixIcon: Icon(Icons.timelapse_rounded),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              readOnly: true,
              onTap: () {
                _showtime();
              },
            ),

            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                filled: true,
                prefixIcon: Icon(Icons.calendar_month_outlined),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 2),
                ),
              ),
              readOnly: true,
              onTap: () {
                _selectdate();
              },
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final cart = Provider.of<Cartmanager>(context, listen: false);
                List<Map<String, dynamic>> items = cart.items.map((item) {
                  return {'name': item.name, 'quantity': item.quantity};
                }).toList();

                await postorder(date: _dateController.text, time: _timeController.text, items: items);

                Navigator.pop(context);
              },

              icon: Icon(Icons.published_with_changes_rounded),
              label: Text("Confirm"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      if(_picked.isBefore(DateTime.now())){
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You can’t pick datebefore today",style: TextStyle(color: Colors.red),)),
        );
        return;
      }
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(_picked);
      });
    }
  }

  void _showtime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
      value,
    ) {

      
      if (value != null) {
        int toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;
        final picktime_min = toMinutes(value);
        final restStart = toMinutes(const TimeOfDay(hour: 12, minute: 0));
        final restEnd = toMinutes(const TimeOfDay(hour: 14, minute: 0));
        final nightStart = toMinutes(const TimeOfDay(hour: 21, minute: 0));
        final nightEnd = toMinutes(const TimeOfDay(hour: 08, minute: 0));
        if (picktime_min >= restStart && picktime_min <= restEnd ){
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You can’t pick time during rest period",style: TextStyle(color: Colors.red),)),
        );
        return;
        }
        else if (picktime_min >= nightStart && picktime_min <= nightEnd){
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You can’t pick time during night period",style: TextStyle(color: Colors.red),)),
        );
        return;
        }
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, value.hour, value.minute);
        final formattedTime = DateFormat('HH:mm:ss').format(dt);
        
        setState(() {
          _timeController.text = formattedTime;
        });
      }
    });
  }
}
