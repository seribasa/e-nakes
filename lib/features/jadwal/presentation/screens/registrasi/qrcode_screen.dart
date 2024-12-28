import 'dart:developer';
import 'dart:io';

import 'package:eimunisasi_nakes/features/jadwal/data/repositories/jadwal_repository.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/verifikasi_pasien_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrRegistrasiPemeriksaan extends StatefulWidget {
  const QrRegistrasiPemeriksaan({super.key});

  @override
  State<StatefulWidget> createState() => _QrRegistrasiPemeriksaanState();
}

class _QrRegistrasiPemeriksaanState extends State<QrRegistrasiPemeriksaan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Scan qr code dari pasien',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              icon: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Icon(
                                      snapshot.data == true
                                          ? Icons.flash_on
                                          : Icons.flash_off,
                                      color: Colors.white);
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              icon: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Icon(
                                      snapshot.data?.name == 'back'
                                          ? Icons.camera_rear
                                          : Icons.camera_front,
                                      color: Colors.white,
                                    );
                                  } else {
                                    return const Text('loading');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: result != null ? Colors.green : Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final jadwalRepository = getIt<JadwalRepository>();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      jadwalRepository. getAppointment(id: scanData.code).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifikasiPasienScreen(
              jadwalPasienModel: value,
              pasien: value?.child,
            ),
          ),
        );
        controller.dispose();
      }).catchError((e) {
        log(e.toString());
        // showSnackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // unlimited duration
            duration: const Duration(days: 365),
            content: const Text('Data tidak ditemukan'),
            action: SnackBarAction(
              label: 'Ulang',
              onPressed: () {
                controller.resumeCamera();
              },
            ),
          ),
        );
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
