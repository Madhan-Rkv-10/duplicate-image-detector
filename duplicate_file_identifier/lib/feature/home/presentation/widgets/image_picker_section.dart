import 'package:flutter/material.dart'
    show
        BuildContext,
        StatelessWidget,
        VoidCallback,
        Widget,
        ElevatedButton,
        Icons,
        Icon,
        Text,
        Colors,
        EdgeInsets;

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onPickImages;
  final bool isProcessing;

  const ImagePickerWidget({
    super.key,
    required this.onPickImages,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isProcessing ? null : onPickImages,
      icon: Icon(Icons.add_photo_alternate),
      label: Text('Pick Images'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade600,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
