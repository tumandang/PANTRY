
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pantry/components/donationtype.dart';
import 'package:pantry/components/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  File? selectedReceipt;
  String? selectedFood;
  String? name;
  String? email;
  final ammount = TextEditingController();

  void initState() {
    super.initState();

    loaduserdata();
  }

  Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'User';
      email = prefs.getString('email') ?? 'Email User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: mydonationtype.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,

                              indicator: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.grey.shade700,
                              tabs: mydonationtype,
                              indicatorColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _buildFoodDonation(context),
                                _buildMoneyDonation(context),
                              ],
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
    );
  }

  Widget _foodCard(String label) {
    final isSelected = selectedFood == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFood = label;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFoodDonation(BuildContext context) {
    final quantity = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Food Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
      
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              children: [
                _foodCard("Canned Food"),
                _foodCard("Fruits & Vegetables"),
                _foodCard("Meal Packs"),
                _foodCard("Bakery Items"),
              ],
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: quantity,
              hintText: '0',
              obscureText: false,
              label: 'Quantity',
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (selectedFood == null || quantity.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a food item and quantity."),
                    ),
                  );
                  return;
                }
                final uri = Uri.parse(
                  'https://eduhosting.top/campusfoodpantry/api_donation.php',
                );
      
                final request = http.MultipartRequest('POST', uri);
                request.fields['name'] = name ?? 'User';
                request.fields['email'] = email ?? 'Email User';
                request.fields['donationType'] = 'Food';
                request.fields['value'] = selectedFood!;
                request.fields['amount'] = quantity.text;
      
                if (selectedReceipt != null) {
                  request.files.add(
                    await http.MultipartFile.fromPath(
                      'receipt',
                      selectedReceipt!.path,
                    ),
                  );
                }
                final response = await request.send();
                // final respStr = await response.stream.bytesToString();
      
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Donation submitted",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Error: ${response.statusCode}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Confirm Donation",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneyDonation(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Money ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                const Text(
                  "Scan this QR to donate:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Image.network(
                      'https://eduhosting.top/campusfoodpantry/qrpic.png',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'pdf'],
                      allowMultiple: false,
                    );
                    if (result == null) return;
                    final file = File(result.files.single.path!);
      
                    setState(() {
                      selectedReceipt = file;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Receipt selected successfully!",style: TextStyle(color: Colors.green),),
                      ),
                    );
                  },
                  icon: Icon(Icons.receipt),
                  label: Text(
                    'Upload Receipt',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    iconColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: ammount,
                  hintText: "50",
                  obscureText: false,
                  label: 'Amount',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(
                      'https://eduhosting.top/campusfoodpantry/api_donation.php',
                    );
      
                    final request = http.MultipartRequest('POST', uri);
                    request.fields['name'] = name ?? 'User';
                    request.fields['email'] = email ?? 'Email User';
                    request.fields['donationType'] = 'Money';
                    request.fields['amount'] = ammount.text;
      
                    if (selectedReceipt != null) {
                      request.files.add(
                        await http.MultipartFile.fromPath(
                          'receipt',
                          selectedReceipt!.path,
                        ),
                      );
                    }
                    final response = await request.send();
                    
      
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Donation submitted",
                            style: TextStyle(color: Colors.amber),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Error: ${response.statusCode}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "I've Donated",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
