import 'package:duplicate_file_identifier/feature/core/utils.dart';
import 'package:flutter/material.dart';

import '../../../app.dart' show StatisticsWidget;
import '../../../main.dart';
import '../domain/image_data.dart' show ImageData;
import '../domain/process_result.dart' show ProcessingResult;
import 'widgets/clear_all_button.dart' show ImageManagementWidget;
import 'widgets/duplicate_image_section.dart' show DuplicateDetectionWidget;
import 'widgets/empty_widget.dart' show EmptyStateWidget;
import 'widgets/image_grid.dart';
import 'widgets/image_picker_section.dart' show ImagePickerWidget;
import 'widgets/loading_widget.dart';

class ImageDuplicateDetectionScreen extends StatefulWidget {
  const ImageDuplicateDetectionScreen({super.key});

  @override
  State<ImageDuplicateDetectionScreen> createState() =>
      _ImageDuplicateDetectionScreenState();
}

class _ImageDuplicateDetectionScreenState
    extends State<ImageDuplicateDetectionScreen> {
  // State
  List<ImageData> _uniqueImages = [];
  List<String> _duplicateMessages = [];
  bool _isProcessing = false;

  // Feature Logic Instances
  final ImagePickerLogic _imagePickerLogic = ImagePickerLogic();
  final DuplicateDetectionLogic _duplicateDetectionLogic =
      DuplicateDetectionLogic();
  final ImageManagementLogic _imageManagementLogic = ImageManagementLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Duplicate Detection'),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade600, Colors.blue.shade50],
              ),
            ),
            child: Column(
              children: [
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImagePickerWidget(
                      onPickImages: _pickMultipleImages,
                      isProcessing: _isProcessing,
                    ),
                    ImageManagementWidget(
                      onClearAll: _clearAll,
                      hasImages: _uniqueImages.isNotEmpty,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Statistics
                StatisticsWidget(
                  uniqueImagesCount: _uniqueImages.length,
                  duplicatesCount: _duplicateMessages.length,
                ),
              ],
            ),
          ),

          // Loading Indicator
          LoadingWidget(isLoading: _isProcessing),

          // Duplicate Messages
          DuplicateDetectionWidget(duplicateMessages: _duplicateMessages),

          // Main Content
          Expanded(
            child: _uniqueImages.isEmpty
                ? EmptyStateWidget()
                : ImageGridWidget(
                    images: _uniqueImages,

                    onRemove: _removeImage,
                    logic: _imageManagementLogic,
                  ),
          ),
        ],
      ),
    );
  }

  // Feature Actions
  Future<void> _pickMultipleImages() async {
    setState(() {
      _isProcessing = true;
      _duplicateMessages.clear();
    });

    try {
      final result = await _imagePickerLogic.pickMultipleImages();

      if (result != null && result.files.isNotEmpty) {
        final processingResult = await _duplicateDetectionLogic
            .processSelectedFiles(result.files, _uniqueImages);

        setState(() {
          _uniqueImages.addAll(processingResult.newImages);
          _duplicateMessages = processingResult.duplicateMessages;
        });

        _showFeedback(processingResult);
      }
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _uniqueImages = _imageManagementLogic.removeImage(_uniqueImages, index);
      if (_uniqueImages.isEmpty) {
        _duplicateMessages.clear();
      }
    });
    _showSnackBar('Image removed');
  }

  void _clearAll() {
    setState(() {
      _uniqueImages = _imageManagementLogic.clearAllImages();
      _duplicateMessages.clear();
    });
    _showSnackBar('All images cleared');
  }

  void _showFeedback(ProcessingResult result) {
    if (result.newImages.isNotEmpty) {
      _showSnackBar('✓ Added ${result.newImages.length} unique images');
    }

    if (result.duplicateMessages.isNotEmpty) {
      _showSnackBar(
        '⚠ ${result.duplicateMessages.length} duplicate(s) detected and ignored',
        isError: true,
      );
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
