import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AiChatUploadMenu extends StatelessWidget {
  final VoidCallback onUploadDocument;
  final VoidCallback onUploadImage;
  final VoidCallback onDismiss;

  const AiChatUploadMenu({
    Key? key,
    required this.onUploadDocument,
    required this.onUploadImage,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0),
        child: Stack(
          children: [
            // Dismiss area (transparent, full screen)
            GestureDetector(
              onTap: onDismiss,
              child: Container(color: Colors.transparent),
            ),

            // Upload menu positioned above the input bar
            Positioned(
              bottom: 80,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Upload Document Option
                    _buildMenuItem(
                      icon: 'assets/ai_chat/upload_document.png',
                      label: 'Upload Document',
                      onTap: () {
                        onDismiss();
                        onUploadDocument();
                      },
                    ),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(height: 1, color: AppColors.ge3),
                    ),

                    // Upload Image Option
                    _buildMenuItem(
                      icon: 'assets/ai_chat/upload_image.png',
                      label: 'Upload Image',
                      onTap: () {
                        onDismiss();
                        onUploadImage();
                      },
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, isLast ? 12 : 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon container with fixed width for alignment
              SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(
                  icon,
                  width: 24,
                  height: 24,
                  color: AppColors.ge2,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 12),

              // Label
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.ge1,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
