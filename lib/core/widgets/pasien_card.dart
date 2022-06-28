import 'package:flutter/material.dart';

class PasienCard extends StatelessWidget {
  final String? nama;
  final String? umur;
  const PasienCard({Key? key, this.nama, this.umur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.blue,
      title: Text(
        '$nama',
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      subtitle: Text(
        '$umur\nLaki-laki',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
