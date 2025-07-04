import 'package:duplicate_file_identifier/feature/home/domain/image_data.dart'
    show ImageData;
import 'package:flutter/material.dart'
    show
        VoidCallback,
        StatelessWidget,
        BuildContext,
        Widget,
        BorderRadius,
        RoundedRectangleBorder,
        CrossAxisAlignment,
        Radius,
        MemoryImage,
        BoxFit,
        DecorationImage,
        BoxDecoration,
        Container,
        Expanded,
        EdgeInsets,
        FontWeight,
        Colors,
        TextStyle,
        TextOverflow,
        Text,
        SizedBox,
        Column,
        MainAxisAlignment,
        MainAxisSize,
        Icons,
        Icon,
        BoxConstraints,
        IconButton,
        Row,
        Card;

import '../../../core/utils.dart' show ImageManagementLogic;

class ImageCardWidget extends StatelessWidget {
  final ImageData imageData;
  final int index;

  final VoidCallback onRemove;
  final ImageManagementLogic logic;

  const ImageCardWidget({
    super.key,
    required this.imageData,
    required this.index,

    required this.onRemove,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: MemoryImage(imageData.uint8List),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageData.fileName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Size: ${logic.formatBytes(imageData.uint8List.length)}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  'Hash: ${imageData.hash.substring(0, 8)}...',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Image ${index + 1}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.red.shade600,
                      ),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(minWidth: 28, minHeight: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
