import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;

  const LoadingWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
          ),
          SizedBox(width: 16),
          Text(
            'Processing images...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
