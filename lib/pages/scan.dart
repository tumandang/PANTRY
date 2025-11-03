import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:huawei_scan/huawei_scan.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});
  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String scanResult = "Scan the Pantry QR Code to continue";

  Future<bool> _ensureCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) return true;
    final result = await Permission.camera.request();
    return result.isGranted;
  }

  Future<void> startScan() async {
    final ok = await _ensureCameraPermission();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
      return;
    }

    try {
      final DefaultViewRequest request = DefaultViewRequest(
        scanType: HmsScanTypes.QRCode, 
        viewType: 1, 
      );

      final ScanResponse? response = await HmsScanUtils.startDefaultView(request);

      if (response?.originalValue != null && response!.originalValue!.isNotEmpty) {
        final result = response.originalValue!;
        setState(() => scanResult = result);

        if (result.contains("api_walkin.php")) {
          Navigator.pushNamed(context, '/ProductQr');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("QR IS INVALID!!!", style: TextStyle(color: Colors.red)),
            ),
          );
        }
      } else {
        
        debugPrint('Scan canceled or returned empty result');
      }
    } catch (e) {
      debugPrint('Scan failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scan failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startScan,
              child: const Text("Start Scanning"),
            ),
          ],
        ),
      ),
    );
  }
}