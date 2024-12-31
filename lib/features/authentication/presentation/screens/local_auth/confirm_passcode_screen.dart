import '../../widgets/confirm_passcode_form.dart';
import 'package:flutter/material.dart';

class ConfirmPasscodeScreen extends StatelessWidget {
  const ConfirmPasscodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ConfirmPasscodeForm(),
      ),
    );
  }
}
