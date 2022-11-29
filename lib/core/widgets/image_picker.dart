import 'dart:async';
import 'dart:io';

import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModalPickerImage {
  final UserRepository _userRepository = UserRepository();

  Future<String> uploadFirebase(context, File image) async =>
      await _userRepository.uploadImage(image);

  FutureOr<File?> _imgFromCamera(context) async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      File imagePath = File(image.path);
      return imagePath;
    }
    return null;
  }

  FutureOr<File?> _imgFromGallery(context) async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      File imagePath = File(image.path);
      return imagePath;
    }
    return null;
  }

  void showPicker(context, Function(String?) callback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Photo Library'),
                    onTap: () async {
                      final image = await _imgFromGallery(context);
                      if (image != null) {
                        uploadFirebase(context, image)
                            .then((value) => callback(value))
                            .catchError((e) => callback(null));
                      }
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    final image = await _imgFromCamera(context);
                    if (image != null) {
                      uploadFirebase(context, image)
                          .then((value) => callback(value))
                          .catchError((e) => callback(null));
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
