import 'dart:typed_data' show Uint8List;

class ImageData {
  final Uint8List uint8List;
  final String fileName;
  final String hash;

  ImageData({
    required this.uint8List,
    required this.fileName,
    required this.hash,
  });

  ImageData copyWith({Uint8List? uint8List, String? fileName, String? hash}) {
    return ImageData(
      uint8List: uint8List ?? this.uint8List,
      fileName: fileName ?? this.fileName,
      hash: hash ?? this.hash,
    );
  }

  @override
  String toString() {
    return 'ImageData{fileName: $fileName, size: ${uint8List.length} bytes, hash: ${hash.substring(0, 8)}...}';
  }
}
