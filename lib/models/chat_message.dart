/// Enum to represent the type of message sender
enum MessageSender { user, ai }

/// Enum to represent attachment type
enum AttachmentType { image, document }

/// Model to hold attachment information
class Attachment {
  final String id;
  final String fileName;
  final String filePath;
  final AttachmentType type;
  final List<int>? fileBytes;
  final int? fileSize;

  Attachment({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.type,
    this.fileBytes,
    this.fileSize,
  });
}

/// Message model to hold text and multiple attachments
class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final List<Attachment> attachments;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.attachments = const [],
  });

  /// Check if this message has attachments
  bool get hasAttachments => attachments.isNotEmpty;

  /// Check if this message has image attachments
  bool get hasImages => attachments.any((a) => a.type == AttachmentType.image);

  /// Check if this message has document attachments
  bool get hasDocuments =>
      attachments.any((a) => a.type == AttachmentType.document);
}
