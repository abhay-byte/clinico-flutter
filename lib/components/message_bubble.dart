import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/chat_message.dart';

/// Message bubble component to display chat messages
class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.sender == MessageSender.user;

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: isUserMessage ? 60 : 12,
          right: isUserMessage ? 12 : 60,
        ),
        child: Column(
          crossAxisAlignment: isUserMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Attachments preview (if message has attachments)
            if (message.hasAttachments)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: message.attachments.length,
                  itemBuilder: (context, index) {
                    final attachment = message.attachments[index];
                    return _buildAttachmentThumbnail(attachment);
                  },
                ),
              ),

            // Text bubble
            if (message.text.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isUserMessage ? Colors.white : AppColors.bg1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isUserMessage ? Colors.black : AppColors.ge1,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build individual attachment thumbnail
  Widget _buildAttachmentThumbnail(Attachment attachment) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 80,
          height: 80,
          color: AppColors.ge3,
          child: attachment.type == AttachmentType.image
              ? Image.file(File(attachment.filePath), fit: BoxFit.cover)
              : Container(
                  color: AppColors.b1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.description,
                          color: AppColors.white,
                          size: 32,
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            _getFileExtension(
                              attachment.fileName,
                            ).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  String _getFileExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.isNotEmpty ? parts.last : 'file';
  }
}
