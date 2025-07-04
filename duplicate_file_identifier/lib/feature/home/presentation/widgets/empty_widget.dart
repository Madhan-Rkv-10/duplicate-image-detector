import 'package:flutter/material.dart'
    show
        MainAxisAlignment,
        BuildContext,
        StatelessWidget,
        Widget,
        EdgeInsets,
        Colors,
        BoxShape,
        BoxDecoration,
        Icons,
        Icon,
        Container,
        SizedBox,
        FontWeight,
        TextStyle,
        Text,
        TextAlign,
        Column,
        Center;

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_library_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No images selected',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap "Pick Images" to select multiple images\nDuplicates will be automatically detected',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
