import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        StatelessWidget,
        Widget,
        Colors,
        VisualDensity,
        ThemeData,
        MaterialApp,
        MainAxisAlignment,
        Row,
        EdgeInsets,
        BorderRadius,
        Offset,
        BoxShadow,
        BoxDecoration,
        FontWeight,
        TextStyle,
        Text,
        SizedBox,
        TextAlign,
        Column,
        Container;

import 'feature/home/presentation/image_duplication.dart'
    show ImageDuplicateDetectionScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Duplicate Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageDuplicateDetectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  final int uniqueImagesCount;
  final int duplicatesCount;

  const StatisticsWidget({
    super.key,
    required this.uniqueImagesCount,
    required this.duplicatesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatCardWidget(
          title: 'Unique Images',
          value: uniqueImagesCount,
          color: Colors.green.shade600,
        ),
        StatCardWidget(
          title: 'Duplicates Found',
          value: duplicatesCount,
          color: Colors.orange.shade600,
        ),
      ],
    );
  }
}

class StatCardWidget extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
