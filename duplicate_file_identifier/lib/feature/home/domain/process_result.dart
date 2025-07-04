import 'package:duplicate_file_identifier/feature/home/domain/image_data.dart';

class ProcessingResult {
  final List<ImageData> newImages;
  final List<String> duplicateMessages;

  ProcessingResult({required this.newImages, required this.duplicateMessages});
}
