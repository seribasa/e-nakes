import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String? nama;
  final String? pekerjaan;
  final String urlGambar;
  const ProfileCard(
      {Key? key, this.nama, this.pekerjaan, required this.urlGambar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(urlGambar),
      ),
      title: Text(
        nama ?? '',
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        pekerjaan ?? '',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
