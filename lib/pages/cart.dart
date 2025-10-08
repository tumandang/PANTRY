import 'package:PANTRY/models/cartmanager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
              Provider.of<Cartmanager>(
                context,
                listen: false,
              ).clear();
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
                        child: 
                        
                        ListTile(
                          
                          leading: Image.asset(item.imageUrl,width: 50,),
                          title: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,style:
                              TextStyle(fontWeight: FontWeight.bold),
                              
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
                                  )
                                ),
                                
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                   constraints: BoxConstraints(),
                                  icon: Icon(Icons.remove,color: Colors.white,),
                                  onPressed: () {
                                    Provider.of<Cartmanager>(
                                      context,
                                      listen: false,
                                    ).updateQuantity(item.id, item.quantity - 1);
                                  },
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment:Alignment.center ,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                  ),
                                  child: 
                                
                                 Text("${item.quantity}",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                 )
                                 
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
                                  )
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                   constraints: BoxConstraints(),
                                  icon: Icon(Icons.add,color: Colors.white,size: 20,),
                                  onPressed: () {
                                    Provider.of<Cartmanager>(
                                      context,
                                      listen: false,
                                    ).updateQuantity(item.id, item.quantity + 1);
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
                            "${value.items.length} items with ",
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
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),

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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Pls Check Order History"),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      right: 20,
                      left: 20,
                    ),
                  ),
                );
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
        setState(() {
          _timeController.text = value.format(context);
        });
      }
    });
  }
}
