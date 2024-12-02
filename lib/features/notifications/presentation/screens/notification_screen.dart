import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Notifikasi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [
              // _ListPesan(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _ListPesan extends StatelessWidget {
  const _ListPesan();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(5, (index) {
          return ListTile(
            title: Text(
              'Booking Imunisasi $index',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
                'NIK $index${index + 1}${index + 2}${index + 3}${index + 4}'),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) => const RekamMedisPasienScreen()),
              // );
            },
          );
        }),
      ),
    );
  }
}
