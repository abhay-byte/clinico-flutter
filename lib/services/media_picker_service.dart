import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

/// Service to handle image and file picking operations
class MediaPickerService {
  static final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from gallery
  static Future<PickedImage?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        return PickedImage(
          filePath: image.path,
          fileName: image.name,
          file: File(image.path),
        );
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
    return null;
  }

  /// Pick an image from camera
  static Future<PickedImage?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (image != null) {
        return PickedImage(
          filePath: image.path,
          fileName: image.name,
          file: File(image.path),
        );
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
    return null;
  }

  /// Pick a document (PDF, Word, etc.)
  static Future<PickedDocument?> pickDocument() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        return PickedDocument(
          filePath: file.path ?? '',
          fileName: file.name,
          fileBytes: file.bytes,
          fileSize: file.size,
        );
      }
    } catch (e) {
      print('Error picking document: $e');
    }
    return null;
  }
}

/// Model for picked image
class PickedImage {
  final String filePath;
  final String fileName;
  final File file;

  PickedImage({
    required this.filePath,
    required this.fileName,
    required this.file,
  });
}

/// Model for picked document
class PickedDocument {
  final String filePath;
  final String fileName;
  final List<int>? fileBytes;
  final int fileSize;

  PickedDocument({
    required this.filePath,
    required this.fileName,
    this.fileBytes,
    required this.fileSize,
  });
}
