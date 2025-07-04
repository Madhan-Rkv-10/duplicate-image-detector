import 'package:flutter/material.dart'
    show
        SizedBox,
        Padding,
        StatelessWidget,
        BuildContext,
        Widget,
        EdgeInsets,
        Colors,
        Border,
        BorderRadius,
        BoxDecoration,
        CrossAxisAlignment,
        Icons,
        Icon,
        FontWeight,
        TextStyle,
        Text,
        Row,
        Expanded,
        Column,
        Container;

class DuplicateDetectionWidget extends StatelessWidget {
  final List<String> duplicateMessages;

  const DuplicateDetectionWidget({super.key, required this.duplicateMessages});

  @override
  Widget build(BuildContext context) {
    if (duplicateMessages.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: Colors.orange.shade600,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Duplicate Images Detected:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...duplicateMessages.map(
            (msg) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.content_copy,
                    size: 16,
                    color: Colors.orange.shade600,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
