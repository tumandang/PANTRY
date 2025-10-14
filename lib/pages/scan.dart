import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry/models/food.dart';
import 'package:pantry/models/cartitem.dart';
import 'package:pantry/models/cartmanager.dart';
import 'package:provider/provider.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // Controller untuk scanner
  MobileScannerController cameraController = MobileScannerController();
  
  String? scannedBarcode;
  Food? scannedFood;
  int quantity = 1;
  bool isScanning = true;
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SCAN BARCODE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans'
          ),
        ),
        actions: [
          // Flashlight Toggle Button
          if (isScanning)
          IconButton(
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: isFlashOn ? Colors.amber : Colors.grey,
            ),
            onPressed: _toggleFlashlight,
            tooltip: isFlashOn ? 'Turn off flashlight' : 'Turn on flashlight',
          ),
        ],
      ),
      body: Column(
        children: [
          // Scanner Area - hanya show ketika scanning mode
          if (isScanning)
          Expanded(
            flex: 2, 
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                children: [
                  // Scanner Camera
                  MobileScanner(
                    controller: cameraController,
                    onDetect: (capture) {
                      // Only process if we're in scanning mode
                      if (!isScanning) return;
                      
                      final List<Barcode> barcodes = capture.barcodes;
                      
                      // Process setiap barcode yang detected
                      for (final barcode in barcodes) {
                        // Check jika barcode ada value
                        if (barcode.rawValue != null) {
                          // Check jika ini adalah barcode baru (berbeza dari sebelumnya)
                          if (scannedBarcode != barcode.rawValue!) {
                            print('New barcode detected: ${barcode.rawValue}');
                            
                            setState(() {
                              scannedBarcode = barcode.rawValue!; // Simpan barcode
                              isScanning = false; // Pause scanner segera
                            });
                            
                            // Cari food berdasarkan barcode (diluar setState untuk performance)
                            _findFoodByBarcode(barcode.rawValue!);
                            
                            // Stop loop setelah jumpa satu valid barcode
                            break;
                          } else {
                            print('Same barcode detected, ignoring: ${barcode.rawValue}');
                          }
                        }
                      }
                    },
                  ),
                  
                  // Scanner overlay dengan instruction
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Align barcode within the frame to scan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Result Area - show ketika ada scanned item (pause scanner)
          if (!isScanning && scannedFood != null && scannedFood!.id != 0)
          Expanded(
            flex: 3, 
            child: _buildResultSection(context),
          ),

          // Placeholder - show ketika scanning mode tapi belum scan apa-apa
          if (isScanning && scannedFood == null)
          Expanded(
            flex: 1,
            child: _buildPlaceholderSection(),
          ),
        ],
      ),
      
      // Floating Action Button untuk manual resume scanning
      floatingActionButton: !isScanning ? FloatingActionButton(
        onPressed: _resumeScanning,
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        tooltip: 'Resume Scanning',
      ) : null,
    );
  }

  /// Function untuk toggle flashlight on/off
  void _toggleFlashlight() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    cameraController.toggleTorch(); // Toggle torch function dari mobile_scanner
  }

  /// Function untuk resume scanning setelah add item
  void _resumeScanning() {
    setState(() {
      isScanning = true; // Enable scanner kembali
      scannedBarcode = null; // Reset barcode - PENTING!
      scannedFood = null; // Reset scanned food
      quantity = 1; // Reset quantity
    });
    print('Scanner resumed - ready for next scan');
  }

  /// Function untuk cari food dalam database berdasarkan barcode
  void _findFoodByBarcode(String barcode) {
    print('Finding food for barcode: $barcode');
    
    // Cari food yang matching barcode
    final foundFood = myFood.firstWhere(
      (food) => food.barcode == barcode,
      // Jika tak jumpa, return unknown product
      orElse: () => Food(
        id: 0, // ID 0 untuk unknown products
        name: "Unknown Product",
        image: "assets/img/unipantry_logo.png",
        stock: 0,
        category: "Unknown",
        barcode: barcode,
      ),
    );

    // Update state dengan food yang ditemui
    setState(() {
      scannedFood = foundFood;
      quantity = 1; // Reset quantity kepada 1 setiap kali scan baru
    });

    print('Food found: ${foundFood.name} (ID: ${foundFood.id})');

    // Jika item tidak available, show popup dan auto-resume
    if (foundFood.id == 0) {
      _showItemNotAvailablePopup();
    }
  }

  /// Function untuk show popup ketika item tidak available
  void _showItemNotAvailablePopup() {
    print('Showing item not available popup');
    
    // Show snackbar popup
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Item not available in pantry',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
      ),
    );

    // Auto-resume scanning setelah 2.5 seconds (sedikit lebih lama dari snackbar duration)
    Future.delayed(Duration(milliseconds: 2500), () {
      if (mounted) {
        print('Auto-resuming after unknown item');
        _resumeScanning();
      }
    });
  }

  /// Widget untuk build placeholder section ketika scanning mode
  Widget _buildPlaceholderSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'Scan a barcode to add item',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Text(
            'Flashlight: ${isFlashOn ? 'ON' : 'OFF'}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  /// Widget untuk build result section berdasarkan scan status
  Widget _buildResultSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header dengan resume button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scanned Item',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: _resumeScanning,
                tooltip: 'Cancel and resume scanning',
              ),
            ],
          ),
          
          Divider(),
          SizedBox(height: 10),

          // ROW 1: Product Information
          Row(
            children: [
              // Product Image
              Image.asset(
                scannedFood!.image,
                width: 80,
                height: 80,
                // Error builder jika image tak boleh load
                errorBuilder: (context, error, stackTrace) => 
                  Icon(Icons.fastfood, size: 60, color: Colors.grey),
              ),
              SizedBox(width: 16),
              
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      scannedFood!.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Product Category
                    Text(
                      "Category: ${scannedFood!.category}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    
                    // Product Stock
                    Text(
                      "Available Stock: ${scannedFood!.stock} pcs",
                      style: TextStyle(
                        fontSize: 14,
                        color: scannedFood!.stock > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    // Barcode Info
                    Text(
                      "Barcode: ${scannedBarcode ?? 'N/A'}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // ROW 2: Quantity Control
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity Label
                Text(
                  'Select Quantity:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                
                // Quantity Selector Container (- quantity +)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      // BUTTON 1: Minus Button (-)
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            // Kurangkan quantity, minimum 1
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      
                      // Quantity Display
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                        ),
                        child: Text(
                          '$quantity', // Display current quantity
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                      
                      // BUTTON 2: Plus Button (+)
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            // Tambah quantity, maximum sampai stock available
                            if (scannedFood!.stock == 0 || quantity < scannedFood!.stock) {
                              quantity++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // BUTTON: Add to Cart
          ElevatedButton.icon(
            onPressed: () {
              print('Adding to cart: ${scannedFood!.name} x$quantity');
              
              // Create CartItem object dari scanned food
              final cartItem = CartItem(
                id: scannedFood!.id,
                name: scannedFood!.name,
                category: scannedFood!.category,
                quantity: quantity,
                stock: scannedFood!.stock,
                imageUrl: scannedFood!.image,
              );
              
              // Tambah item ke cart menggunakan CartManager
              Provider.of<Cartmanager>(context, listen: false).additem(cartItem);
              
              // Show berjaya! message menggunakan SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("✅ $quantity ${scannedFood!.name} added to cart"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );

              // Auto-resume scanning setelah add item
              _resumeScanning();
            },
            
            icon: Icon(Icons.add_shopping_cart),
            label: Text("Add to Cart", style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
          
          SizedBox(height: 10),
          
          // Secondary Button untuk cancel
          TextButton.icon(
            onPressed: _resumeScanning,
            icon: Icon(Icons.qr_code_scanner),
            label: Text('Scan Another Item'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Cleanup controller ketika page ditutup
    cameraController.dispose();
    super.dispose();
  }
}