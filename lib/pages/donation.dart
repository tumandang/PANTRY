import 'package:flutter/material.dart';
import 'package:pantry/components/donationtype.dart';
import 'package:pantry/components/textfield.dart';

class DonationPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
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
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.only( 
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)
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
                            child:TabBar(
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
                                _buildMoneyDonation(context)
                              ]
                              )
                          )
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border:Border.all(color: Colors.grey.shade300),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
 Widget _buildFoodDonation(BuildContext context) {
  final quantity = TextEditingController();
    return Padding(
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
              mainAxisSpacing:12,
              shrinkWrap: true,
              children: [
                _foodCard("Canned Food"),
                _foodCard("Fruits & Vegetables"),
                _foodCard("Meal Packs"),
                _foodCard("Bakery Items"),
              ],
            ),
          SizedBox(height: 20),
          MyTextField(controller: quantity, hintText: '0', obscureText: false, label: 'Quantity'),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text("Confirm Donation", 
            style: TextStyle(
              fontSize: 18,color: Colors.white
              )
              ),
          ),
        ],
      ),
    );
  }
   Widget _buildMoneyDonation(BuildContext context) {
    return Padding(
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
              const Text("Scan this QR to donate:", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, size: 100, color: Colors.orange),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("I've Donated", 
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
