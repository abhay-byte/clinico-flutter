import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/ai_chat_upload_menu.dart';
import '../components/ai_chat_drawer.dart';
import '../components/message_bubble.dart';
import '../models/chat_message.dart';
import '../services/media_picker_service.dart';
import 'appointment_search_page.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  late TextEditingController _messageController;
  final FocusNode _messageFocusNode = FocusNode();
  bool _isInputEmpty = true;
  bool _showUploadMenu = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Multiple attachments state
  final List<Attachment> _attachments = [];

  // Chat messages list
  final List<ChatMessage> _messages = [];

  // Placeholder user name - will be fetched from database in future
  final String _userName = 'Lorem Ipsum';

  // Show AI action block after response
  bool _showAiActionBlock = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messageController.addListener(_updateSendButtonState);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _updateSendButtonState() {
    setState(() {
      _isInputEmpty =
          _messageController.text.trim().isEmpty && _attachments.isEmpty;
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    // Allow sending if there's text OR attachments
    if (text.isEmpty && _attachments.isEmpty) return;

    // Create and add message
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      attachments: List.from(_attachments),
    );

    setState(() {
      _messages.add(message);
      _messageController.clear();
      _attachments.clear();
      _isInputEmpty = true;
      _showAiActionBlock = false;
    });

    print('Message sent: $text with \\${_attachments.length} attachments');

    // Simulate AI response after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showAiActionBlock = true;
          // Optionally, add the AI's real response here
        });
      }
    });
  }

  Future<void> _handleUploadDocument() async {
    print('Upload Document tapped');
    _closeUploadMenu();

    final pickedDocument = await MediaPickerService.pickDocument();
    if (pickedDocument != null) {
      setState(() {
        _attachments.add(
          Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            fileName: pickedDocument.fileName,
            filePath: pickedDocument.filePath,
            type: AttachmentType.document,
            fileBytes: pickedDocument.fileBytes,
            fileSize: pickedDocument.fileSize,
          ),
        );
        _updateSendButtonState();
      });
    }
  }

  Future<void> _handleUploadImage() async {
    print('Upload Image tapped');

    // Show options: Camera or Gallery
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Camera option
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: AppColors.b4),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),

                // Gallery option
                ListTile(
                  leading: const Icon(Icons.photo_library, color: AppColors.b4),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await MediaPickerService.pickImageFromCamera();
    if (pickedImage != null) {
      setState(() {
        _attachments.add(
          Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            fileName: pickedImage.fileName,
            filePath: pickedImage.filePath,
            type: AttachmentType.image,
          ),
        );
        _updateSendButtonState();
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await MediaPickerService.pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        _attachments.add(
          Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            fileName: pickedImage.fileName,
            filePath: pickedImage.filePath,
            type: AttachmentType.image,
          ),
        );
        _updateSendButtonState();
      });
    }
  }

  void _removeAttachment(String attachmentId) {
    setState(() {
      _attachments.removeWhere((a) => a.id == attachmentId);
      _updateSendButtonState();
    });
  }

  void _toggleUploadMenu() {
    setState(() {
      _showUploadMenu = !_showUploadMenu;
    });
  }

  void _closeUploadMenu() {
    setState(() {
      _showUploadMenu = false;
    });
  }

  void _navigateToAppointmentSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AppointmentSearchPage()),
    );
  }

  void _showMoreInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('More information coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bg1,
      drawer: AiChatDrawer(
        recentConversations: [
          'What are this rash on my...',
          'I am having Suicidal tho...',
          'I am having sever chest...',
        ],
        onHomeTap: () {
          Navigator.of(context).pop(); // Close the drawer
          // Go back to the previous screen (HomeScreen inside MainAppScreen)
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Top Navigation Bar
              _buildNavigationBar(),

              // Messages List
              Expanded(
                child: _messages.isEmpty
                    ? _buildWelcomeSection()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        itemCount:
                            _messages.length + (_showAiActionBlock ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (_showAiActionBlock && index == _messages.length) {
                            return AiResponseActionBlock(
                              onBookAppointment: _navigateToAppointmentSearch,
                              onMoreInfo: _showMoreInfo,
                            );
                          }
                          return MessageBubble(message: _messages[index]);
                        },
                      ),
              ),

              // Input Area with Image Preview
              _buildInputArea(),
            ],
          ),

          // Upload Menu Overlay
          if (_showUploadMenu)
            AiChatUploadMenu(
              onUploadDocument: _handleUploadDocument,
              onUploadImage: _handleUploadImage,
              onDismiss: _closeUploadMenu,
            ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Elphie Mascot
          Image.asset(
            'assets/home/mascot.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 24),

          // Greeting Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Hello there\n$_userName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.ge1,
                fontFamily: 'Roboto',
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Instructional Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Navigate your wellness journey with confidence. Ask Elphie for support, answers, or to book an appointment.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.ge2,
                fontFamily: 'Roboto',
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return SafeArea(
      child: Container(
        color: AppColors.bg1,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Chat Icon (Drawer trigger)
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                'assets/ai_chat/message_outline.png',
                width: 24,
                height: 24,
                color: AppColors.ge2,
              ),
            ),

            const Spacer(),

            // Home Icon (Navigation)
            GestureDetector(
              onTap: () {
                // Go back to the previous screen (HomeScreen inside MainAppScreen)
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'assets/ai_chat/home_outline.png',
                width: 24,
                height: 24,
                color: AppColors.ge2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      color: AppColors.bg1,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Attachments preview (horizontal scrollable list)
          if (_attachments.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _attachments.length,
                itemBuilder: (context, index) {
                  final attachment = _attachments[index];
                  return _buildAttachmentThumbnail(attachment);
                },
              ),
            ),

          // Input bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Attach Icon (Plus)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: _toggleUploadMenu,
                    child: Image.asset(
                      'assets/ai_chat/plus.png',
                      width: 20,
                      height: 20,
                      color: AppColors.ge2,
                    ),
                  ),
                ),

                // Text Input Field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: _messageFocusNode,
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _isInputEmpty ? null : _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Ask any medical query...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.ge2,
                        fontFamily: 'Roboto',
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),

                // Send Icon
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: _isInputEmpty ? null : _sendMessage,
                    child: Image.asset(
                      'assets/ai_chat/send.png',
                      width: 20,
                      height: 20,
                      color: _isInputEmpty ? AppColors.ge3 : AppColors.b4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentThumbnail(Attachment attachment) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          // Thumbnail
          ClipRRect(
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

          // Remove button
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _removeAttachment(attachment.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFE74C3C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFileExtension(String fileName) {
    final parts = fileName.split('.');
    return parts.isNotEmpty ? parts.last : 'file';
  }
}

// Updated AiResponseActionBlock widget
// 1. Render AiResponseActionBlock as a chat message in the ListView
// 2. Use Expanded for both buttons to prevent overflow
class AiResponseActionBlock extends StatelessWidget {
  final VoidCallback onBookAppointment;
  final VoidCallback onMoreInfo;

  const AiResponseActionBlock({
    super.key,
    required this.onBookAppointment,
    required this.onMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Would you like me to help you find a dermatologist or book an appointment?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF248BEB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppointmentSearchPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: Text(
                              'Book Appointment',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF248BEB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: onMoreInfo,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: Text(
                              'More Information',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
