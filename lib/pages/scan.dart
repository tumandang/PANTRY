import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  if (scanData.code!.contains("api_walkin.php")) {
                    Navigator.pushNamed(context, '/ProductQr');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "QR IS INVALID!!!",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('Scan the Pantry QR Code to continue'),
        ],
      ),
    );
  }

  void _onQrViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code!.contains("api_walkin.php")) {
        Navigator.pushNamed(context, '/ProductQr');
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
