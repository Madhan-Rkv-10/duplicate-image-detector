import 'dart:io' show File;

import 'package:crypto/crypto.dart' show sha256;
import 'package:file_picker/file_picker.dart'
    show FilePickerResult, FilePicker, PlatformFile, FileType;
import 'package:flutter/foundation.dart' show Uint8List;

import '../home/domain/image_data.dart' show ImageData;
import '../home/domain/process_result.dart';

abstract class Utils {}

class ImageManagementLogic {
  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  ImageData renameImage(ImageData imageData, String newName) {
    return imageData.copyWith(fileName: newName);
  }

  List<ImageData> removeImage(List<ImageData> images, int index) {
    return List.from(images)..removeAt(index);
  }

  List<ImageData> clearAllImages() {
    return [];
  }
}

class StatisticsLogic {
  Map<String, int> calculateStats(
    List<ImageData> images,
    List<String> duplicates,
  ) {
    return {
      'uniqueImages': images.length,
      'duplicatesFound': duplicates.length,
    };
  }
}

class DuplicateDetectionLogic {
  String generateContentHash(Uint8List imageData) {
    var digest = sha256.convert(imageData);
    return digest.toString();
  }

  Future<ProcessingResult> processSelectedFiles(
    List<PlatformFile> files,
    List<ImageData> existingImages,
  ) async {
    List<ImageData> newImages = [];
    List<String> duplicateMessages = [];

    for (PlatformFile file in files) {
      try {
        Uint8List? uint8List = file.bytes;

        if (uint8List == null && file.path != null) {
          File actualFile = File(file.path!);
          uint8List = await actualFile.readAsBytes();
        }

        if (uint8List == null) {
          duplicateMessages.add('${file.name} (could not read file data)');
          continue;
        }

        String hash = generateContentHash(uint8List);
        String fileName = file.name;

        bool isDuplicateInExisting = existingImages.any(
          (existingImage) => existingImage.hash == hash,
        );

        if (isDuplicateInExisting) {
          duplicateMessages.add('$fileName (identical to existing image)');
          continue;
        }

        bool isDuplicateInBatch = newImages.any(
          (newImage) => newImage.hash == hash,
        );

        if (isDuplicateInBatch) {
          duplicateMessages.add('$fileName (duplicate within selection)');
        } else {
          newImages.add(
            ImageData(uint8List: uint8List, fileName: fileName, hash: hash),
          );
        }
      } catch (e) {
        duplicateMessages.add('${file.name} (error processing: $e)');
      }
    }

    return ProcessingResult(
      newImages: newImages,
      duplicateMessages: duplicateMessages,
    );
  }
}

class ImagePickerLogic {
  Future<FilePickerResult?> pickMultipleImages() async {
    try {
      return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'],
        allowMultiple: true,
        withData: true,
      );
    } catch (e) {
      throw Exception('Error picking images: $e');
    }
  }
}
