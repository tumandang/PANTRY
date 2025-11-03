import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<dynamic> orders = [];
  bool isLoading = true;
  String? id;

  @override
  void initState() {
    super.initState();
    loaduserdata();
  }

  Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    final storedID = prefs.getString('id');

    if (storedID != null && storedID.isNotEmpty) {
      setState(() {
        id = storedID;
      });

      await loadOrders(storedID);
    } else {
      print("No student ID found in SharedPreferences.");
      setState(() => isLoading = false);
    }
  }

  Future<void> loadOrders(String studentID) async {
    try {
      // final String studentID = 'DA1234';
      final response = await http.get(
        Uri.parse(
          'https://eduhosting.top/campusfoodpantry/get_order.php?studentID=$id',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          setState(() {
            orders = data['orders'];
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          print("No orders found");
        }
      } else {
        print("Server error: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching orders: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/homepage'); 
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(child: Text("No orders found"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final String id = order['id'].toString();
                final String item = order['item'].toString();
                final String studentID = order['studentID'].toString();
                final String time = order['time'].toString();
                final String date = order['date'].toString();
                final String status = order['status'].toString();

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #$id',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          _statusChip(status),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(date),
                            Text(
                              time,
                              style: const TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        const Divider(),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,

                          title: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text('Student ID: $studentID'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'Complete':
        color = Colors.green;
        break;
      case 'Processing':
        color = Colors.orange;
        break;
      case 'Canceled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
