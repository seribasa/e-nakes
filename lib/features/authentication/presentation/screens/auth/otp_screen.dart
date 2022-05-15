// ignore_for_file: prefer_const_constructors

import 'package:eimunisasi_nakes/features/authentication/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OTPForm(),
        ),
      ),
    );
  }
}
