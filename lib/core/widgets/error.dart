import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final VoidCallback? onRefresh;
  final String? message;
  final String? title;

  const ErrorContainer({
    super.key,
    this.onRefresh,
    this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Icon(
            Icons.error_outline,
            color: Colors.red.shade400,
            size: 60,
          ),
          SizedBox(height: 8),
          Text(
            title ?? 'Terjadi Kesalahan, Coba Lagi',
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: onRefresh,
            child: Text(
              message ?? 'Try Again',
            ),
          ),
        ],
      ),
    );
  }
}
