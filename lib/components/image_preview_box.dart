import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Image preview component that displays above the text input bar
/// Shows selected image with filename and remove button
class ImagePreviewBox extends StatelessWidget {
  final String filePath;
  final String fileName;
  final VoidCallback onRemove;

  const ImagePreviewBox({
    super.key,
    required this.filePath,
    required this.fileName,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ge3, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image preview area with remove button
          Stack(
            children: [
              // Dark rectangular preview area with image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: AppColors.ge1,
                  child: Image.file(File(filePath), fit: BoxFit.cover),
                ),
              ),

              // Remove button (red circle with white X)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE74C3C), // Red color
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Filename text
          Text(
            fileName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.ge1,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
