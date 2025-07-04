import 'package:flutter/material.dart'
    show
        VoidCallback,
        StatelessWidget,
        BuildContext,
        Widget,
        ElevatedButton,
        Icons,
        Icon,
        Text,
        Colors,
        EdgeInsets;

class ImageManagementWidget extends StatelessWidget {
  final VoidCallback onClearAll;
  final bool hasImages;

  const ImageManagementWidget({
    super.key,
    required this.onClearAll,
    required this.hasImages,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: hasImages ? onClearAll : null,
      icon: Icon(Icons.clear_all),
      label: Text('Clear All'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
