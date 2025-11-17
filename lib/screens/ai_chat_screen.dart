import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/ai_chat_upload_menu.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  late TextEditingController _messageController;
  final FocusNode _messageFocusNode = FocusNode();
  bool _isInputEmpty = true;
  bool _showUploadMenu = false;

  // Placeholder user name - will be fetched from database in future
  final String _userName = 'Lorem Ipsum';

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
      _isInputEmpty = _messageController.text.trim().isEmpty;
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Handle message sending
      print('Message sent: ${_messageController.text}');
      // Clear input field after sending
      _messageController.clear();
    }
  }

  void _handleUploadDocument() {
    print('Upload Document tapped');
    // File picker functionality will be added here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document upload - Coming soon'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  void _handleUploadImage() {
    print('Upload Image tapped');
    // Image picker functionality will be added here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image upload - Coming soon'),
        duration: Duration(milliseconds: 1500),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Stack(
        children: [
          Column(
            children: [
              // Top Navigation Bar
              _buildNavigationBar(),

              // Main Content Area - Welcome Section
              Expanded(
                child: SingleChildScrollView(
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
                ),
              ),

              // Query Input Bar
              _buildQueryInputBar(),
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

  Widget _buildNavigationBar() {
    return SafeArea(
      child: Container(
        color: AppColors.bg1,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Chat Icon (Decorative)
            Image.asset(
              'assets/home/messages.png',
              width: 24,
              height: 24,
              color: AppColors.ge2,
            ),

            const Spacer(),

            // Home Icon (Navigation)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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

  Widget _buildQueryInputBar() {
    return Container(
      color: AppColors.bg1,
      padding: const EdgeInsets.all(20),
      child: Container(
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
    );
  }
}
